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
            return VisualRecognition(apiKey: Constants.api_key, version: Constants.version)
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
                visualRecognition.updateLocalModel(classifierID: modelId)
            }
        }
        
        if Constants.models.first != "" {
            hasLocalModel = true
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            self.classify(image: image)
            self.allowsEditing()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - VisualRecognition
    
    func classify(image: UIImage, threshold: Double = 0.0) {
        
        SVProgressHUD.show(withStatus: "Classificando")
        
        if hasLocalModel {
            visualRecognition.classifyWithLocalModel(image: image, classifierIDs: Constants.models, threshold: threshold, failure: { error in
                print("[ visualRecognition.classifyWithLocalModel ]: \(error.localizedDescription)")
                self.alert(message: error.localizedDescription, title: "Erro encontrado")
            }) { classifiedImages in
                self.display(result: classifiedImages)
            }
        } else {
            visualRecognition.classify(image: image) { classifiedImages in
                self.display(result: classifiedImages)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func useImagePicker(with sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func allowsEditing() {
        imagePicker.allowsEditing = true
    }
    
    private func display(result: ClassifiedImages) {
        guard let classifiedImage = result.images.first else { return }
        guard let classifiedResult = classifiedImage.classifiers.first else { return }
        
        var results = ""
        for result in classifiedResult.classes {
            if let score = result.score {
                results.append("\(result.className): \(score)\n")
            }
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.alert(message: results, title: "Visual Recognition")
        }
    }
    
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

