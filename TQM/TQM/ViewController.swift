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
        
        // Tabs Font color
        let selectedFontColor = UIColor.white
        let unselectedFontColor = UIColor.white
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedFontColor
        ]
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: unselectedFontColor
        ]
        
        tabs.setTitleTextAttributes(selectedAttributes, for: .selected)
        tabs.setTitleTextAttributes(unselectedAttributes, for: .normal)
//        
//        // Tabs Background color
//        let selectedBackgroundColor = UIImage(color: .blue)  // A utility extension, see below.
//        let unselectedBackgroundColor = UIImage(color: .gray) // A utility extension, see below.
//
//        tabs.setBackgroundImage(selectedBackgroundColor, for: .selected, barMetrics: .default)
//        tabs.setBackgroundImage(unselectedBackgroundColor, for: .normal, barMetrics: .default)

    }

    
    @IBOutlet var tabs: UISegmentedControl!;
}



extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
