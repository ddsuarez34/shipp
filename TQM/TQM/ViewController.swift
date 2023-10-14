//
//  ViewController.swift
//  TQM
//
//  Created by Diego De Dios on 10/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
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
}
