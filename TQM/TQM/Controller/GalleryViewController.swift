//
//  GalleryViewController.swift
//  TQM
//
//  Created by Diego De Dios on 10/15/23.
//

import UIKit

class GalleryViewController: UIViewController {
   
    var customImageViews: [CustomTileView] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        print("GalleryViewController loaded!")
        self.view.backgroundColor = .blue

        for _ in 0..<9 {
            let customImageView = CustomTileView()
            customImageView.imageView.image = #imageLiteral(resourceName: "selfie")
            customImageView.numberOfLikes = Int.random(in: 1...100) // Example to set random likes
            customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            customImageViews.append(customImageView)
        }
        
        
        // Create a vertical UIStackView
               let stackView = UIStackView(arrangedSubviews: customImageViews)
               stackView.axis = .vertical
               stackView.distribution = .fillEqually
               stackView.spacing = 10
               stackView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        stackView.layer.borderWidth = 5

        
        // Add the stackView to the ViewController's view and set constraints
               view.addSubview(stackView)
               stackView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
               ])
    }
}
