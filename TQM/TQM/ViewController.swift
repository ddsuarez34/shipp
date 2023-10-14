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

}
