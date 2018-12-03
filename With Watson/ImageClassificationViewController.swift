//
//  ViewController.swift
//  With Watson
//
//  Created by Victor Shinya on 02/12/18.
//  Copyright © 2018 Victor Shinya. All rights reserved.
//

import UIKit
import VisualRecognition

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Global variables
    
    let imagePicker = UIImagePickerController()
    
    let visualRecognition: VisualRecognition = {
        if !Constants.api_key.isEmpty {
            return VisualRecognition(apiKey: Constants.api_key, version: Constants.version)
        }
        return VisualRecognition(version: Constants.version, apiKey: Constants.apikey)
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
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
    
    func classify(image: UIImage) {
        
        visualRecognition.classify(image: image) { classifiedImages in
            
            guard let classifiedImage = classifiedImages.images.first else { return }
            guard let classifiedResult = classifiedImage.classifiers.first else { return }
            
            var results = ""
            for result in classifiedResult.classes {
                if let score = result.score {
                    results.append("\(result.className): \(score)\n")
                }
            }
            
            DispatchQueue.main.async {
                self.display(message: results, title: "Visual Recognition")
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
    
    private func display(message: String, title: String = "") {
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

