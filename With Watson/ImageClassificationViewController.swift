//
//  ImageClassificationViewController.swift
//  With Watson
//
//  Created by Victor Shinya on 02/12/18.
//  Copyright © 2018 Victor Shinya. All rights reserved.
//

import UIKit
import VisualRecognition
import SVProgressHUD

class ImageClassificationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Global variables
    
    let imagePicker = UIImagePickerController()
    
    let visualRecognition: VisualRecognition = {
        if !Constants.api_key.isEmpty {
            return VisualRecognition(version: Constants.version, apiKey: Constants.api_key)
        }
        return VisualRecognition(version: Constants.version, apiKey: Constants.apikey)
    }()
    
    var hasLocalModel = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let localModels = try? visualRecognition.listLocalModels() else { return }
        
        for modelId in Constants.models {
            if !localModels.contains(modelId) {
                visualRecognition.updateLocalModel(classifierID: modelId) { response, error in
                    if let err = error, let description = err.errorDescription {
                        print("[ visualRecognition.updateLocalModel ]: \(description)")
                    }
                }
            }
        }
        
        if Constants.models.first != "" {
            hasLocalModel = true
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
             self.classify(image: image)
            self.allowsEditing()
        }
    }
    
    // MARK: - VisualRecognition
    
    /**
     Image classification using Visual Recognition® service running on IBM Cloud platform.
     
     - parameter image: The image to classify.
     - parameter threshold: The minimum score a class must have to be displayed in the response.
     */
    private func classify(image: UIImage, threshold: Double = 0.0) {
        if Constants.apikey == "" && Constants.api_key == "" {
            self.alert(message: NSLocalizedString("error_missing_credentials", comment: "Missing Credentials"), title: NSLocalizedString("error_configuration", comment: "Configuration error"))
            return
        }
        
        SVProgressHUD.show(withStatus: NSLocalizedString("classifying", comment: "Classifying"))
        
        if hasLocalModel {
            visualRecognition.classifyWithLocalModel(image: image, classifierIDs: Constants.models, threshold: threshold) { classifiedImages, error in
                if let err = error, let description = err.errorDescription {
                    print("[ visualRecognition.classifyWithLocalModel ]: \(description)")
                } else if let classified = classifiedImages {
                    self.display(result: classified)
                }
                
            }
        } else {
            visualRecognition.classify(image: image) { response, error  in
                if let err = error, let description = err.errorDescription {
                    print("[ visualRecognition.classify ]: \(description)")
                } else if let res = response, let classifiedImages = res.result {
                    self.display(result: classifiedImages)
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    /**
     Pick image from any source type available on iOS.
     
     - parameter with: The source type to pick the image.
     */
    private func useImagePicker(with sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
     Allow your UIImagePicker instance to edit.
     */
    private func allowsEditing() {
        imagePicker.allowsEditing = true
    }
    
    /**
     Display image classification result from ClassifiedImages class.
     
     - parameter result: The classified image list from Visual Recognition®.
     */
    private func display(result: ClassifiedImages) {
        guard let classifiedImage = result.images.first else { return }
        guard let classifiedResult = classifiedImage.classifiers.first else { return }
        
        var results = ""
        for result in classifiedResult.classes {
            results.append("\(result.className): \(result.score)\n")
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.alert(message: results, title: "Watson Visual Recognition")
        }
    }
    
    /**
     Display a simple alert using UIAlertController class.
     
     - parameter message: The body message.
     - parameter title: The title message.
     */
    private func alert(message: String, title: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func openCamera(_ sender: Any) {
        useImagePicker(with: .camera)
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        useImagePicker(with: .photoLibrary)
    }
}

