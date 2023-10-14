//
//  ViewController.swift
//  TQM
//
//  Created by Diego De Dios on 10/14/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        signInStack.isHidden = false;
        signUpStack.isHidden = true;
        pickedImageView.isHidden = false;
    }
    
    // Tabs
    @IBAction func onSignUpTabClick(_ sender: Any) {
        signInStack.isHidden = true;
        signUpStack.isHidden = false;

    }
    @IBAction func onSignInTabClick(_ sender: Any) {
        signInStack.isHidden = false;
        signUpStack.isHidden = true;
    }
    
    @IBOutlet var signUpStack: UIStackView!
    @IBOutlet var signInStack: UIStackView!
    
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
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Use the pickedImage
            pickedImageView.image = pickedImage
            pickedImageView.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet var pickedImageView: UIImageView!
}



