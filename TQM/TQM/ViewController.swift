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
        
        
        let font = UIFont(name: "Arial", size: 14);
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: font
        ];
        
        tabs.setTitleTextAttributes(normalTextAttributes, for: .normal);
    }
    
    @IBOutlet var tabs: UISegmentedControl!;
}
