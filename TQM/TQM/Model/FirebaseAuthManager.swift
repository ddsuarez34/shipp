//
//  FirebaseAuthManager.swift
//  TQM
//
//  Created by Diego De Dios on 10/15/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    private init() {}
    
    func getCurrentUserID() -> String? {
          return Auth.auth().currentUser?.uid
      }
    
    // Sign Up User
    func signUp(email: String, password: String, image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let user = authResult?.user else {
                completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                return
            }
            
            // Upload image to Firebase Storage
            guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Image processing failed"]))
                return
            }
            
            let imageRef = self.storage.child("profile_images/\(user.uid).jpg")
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    // If there's an error uploading the image, delete the user from Firebase Authentication
                    user.delete { (deleteError) in
                        completion(false, deleteError ?? error)
                    }
                    return
                }
                
                
                // Create a user document in Firestore
                let userDocument: [String: Any] = [
                    "email": email,
                    "profileImageURL": imageRef.fullPath // Store the path to the image in Firestore
                ]
                
                self.db.collection("users").document(user.uid).setData(userDocument) { (error) in
                    if let error = error {
                        // If there's an error creating the document, delete the user from Firebase Authentication
                        user.delete { (deleteError) in
                            completion(false, deleteError ?? error)
                        }
                    } else {
                        completion(true, nil)
                    }
                }
            }
        }
    }
        
        // Log in with email + password
        func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                print("Login sent")
                if let error = error {
                    print(error)
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
        
        
        // Call to check if user is logged in
        func isUserLoggedIn(completion: @escaping (Bool) -> Void) {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        
        // Sign off
        func signOut() -> Bool {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                print("Error signing out: \(error.localizedDescription)")
                return false
            }
        }
    }

