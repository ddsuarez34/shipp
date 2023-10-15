//
//  ViewController.swift
//  TQM
//
//  Created by Diego De Dios on 10/14/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var hideshow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        hideshow.isHidden = true
    }
    
    // Tabs
    @IBAction func onSignUpTabClick(_ sender: Any) {
        hideshow.isHidden = !hideshow.isHidden
    }
        
    // Image picker
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func onCameraBtnClick(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func onGallerybtnClick(_ sender: Any) {
        openGallery();
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }

    func openGallery() {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageView = pickedImageView {
            // Use the pickedImage
            imageView.image = pickedImage
            imageView.isHidden = false
            print("Image was picked")
            
            // Set aspect ratio constraint
                    let aspectRatio = pickedImage.size.height / pickedImage.size.width
                    let aspectRatioConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: aspectRatio, constant: 0)
                    NSLayoutConstraint.activate([aspectRatioConstraint])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet var pickedImageView: UIImageView!
}



