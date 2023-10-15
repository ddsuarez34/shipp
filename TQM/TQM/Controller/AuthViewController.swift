//
//  ViewController.swift
//  TQM
//
//  Created by Diego De Dios on 10/14/23.
//

import UIKit

class AuthViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var isSignIn: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        hideshow.isHidden = true
        addLineToButton(button: signInTab, color: UIColor(hex: "F66C72"))
    }
    
    @IBOutlet var signInTab: UIButton!
    @IBOutlet var signUpTab: UIButton!
    
    @IBAction func submitBtnOnClick(_ sender: UIButton) {
        print(isSignIn)
        if isSignIn {
            loginButtonTapped(sender)
        } else {
            signUpButtonTapped(sender)
        }
    }
    
    // Action for Sign Up Submit button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        FirebaseAuthManager.shared.signUp(email: email, password: password) { (success, error) in
            if success {
                // Successfully signed up
                // Navigate to next screen or show success message
                print("Success!")
                self.performSegue(withIdentifier: "SubmitToEvents", sender: self)
            } else {
                // Handle error
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Login Submit
    @IBAction func loginButtonTapped(_ sender: UIButton) {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                // Handle empty email or password fields
                return
            }
            
        FirebaseAuthManager.shared.login(email: email, password: password) { (success, error) in
                if success {
                    // Successfully logged in
                    // Navigate to the main app screen or show a success message
                    print("Success!")
                    self.performSegue(withIdentifier: "SubmitToEvents", sender: self)
                } else {
                    // Handle error
                    if let error = error {
                        print("Error logging in: \(error.localizedDescription)")
                        // Optionally, show an error message to the user
                    }
                }
            }
        }
    
    
    @IBOutlet var hideshow: UIView!
    
    // Tabs
    // Tabs
    @IBAction func onSignUpTabClick(_ sender: UIButton) {
        if sender == signInTab {
            isSignIn = true
            hideshow.isHidden = true
            addLineToButton(button: signInTab, color: UIColor(hex: "F66C72"))
            removeLineFromButton(button: signUpTab)
        } else {
            isSignIn = false
            hideshow.isHidden = false
            addLineToButton(button: signUpTab, color: UIColor(hex: "F66C72"))
            removeLineFromButton(button: signInTab)
        }
        print(isSignIn)
    }
    
    func removeLineFromButton(button: UIButton) {
        button.subviews.forEach {
            if $0.tag == 1001 {
                $0.removeFromSuperview()
            }
        }
    }
    
    func addLineToButton(button: UIButton, color: UIColor) {
        // Remove any existing line
        button.subviews.forEach {
            if $0.tag == 1001 {
                $0.removeFromSuperview()
            }
        }
        
        // Create a new line view
        let lineView = UIView(frame: CGRect(x: 0, y: button.bounds.height, width: button.bounds.width, height: 2))
        lineView.backgroundColor = color
        lineView.tag = 1001  // Tag to identify the line view later
        button.addSubview(lineView)
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



extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgb: UInt64 = 0
        
        scanner.scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
