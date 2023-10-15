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

        let uid = FirebaseAuthManager.shared.getCurrentUserID()
        let imagePath = "/profile_images/\(uid ?? "unknown").jpg"
        print(imagePath)
        for _ in 0..<9 {
            let customImageView = CustomTileView()
            customImageView.imageView.image = #imageLiteral(resourceName: "selfie")
            customImageView.numberOfLikes = Int.random(in: 1...100) // Example to set random likes
            customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            customImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            customImageViews.append(customImageView)
            FirebaseStorageManager.shared.downloadImage(from: imagePath) { image in
                customImageView.imageView.image = image
            }
        }
        
        // Create a vertical UIStackView
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10

        // Divide the customImageViews into chunks of 3 and create horizontal stack views
        for i in stride(from: 0, to: customImageViews.count, by: 3) {
            let endIndex = i + 3
            let views = Array(customImageViews[i..<min(endIndex, customImageViews.count)])
            let horizontalStackView = UIStackView(arrangedSubviews: views)
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 10
            mainStackView.addArrangedSubview(horizontalStackView)
        }
        
        // Add the mainStackView to the ViewController's view and set constraints
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}
