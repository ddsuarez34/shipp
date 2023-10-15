//
//  FirebaseStorageManager.swift
//  TQM
//
//  Created by Diego De Dios on 10/15/23.
//

import FirebaseStorage
import UIKit

class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private init() {}

    private let storage = Storage.storage().reference()
    
    let maxSize: Int64 = 10 * 1024 * 1024 // 10MB
    func downloadImage(from path: String, completion: @escaping (UIImage?) -> Void) {
        let imageRef = storage.child(path)
        imageRef.getData(maxSize: maxSize) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
            } else if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
}
