//
//  FirebaseAuthManager.swift
//  TQM
//
//  Created by Diego De Dios on 10/15/23.
//

import FirebaseAuth

class FirebaseAuthManager {
    
    // Sign Up User
    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
