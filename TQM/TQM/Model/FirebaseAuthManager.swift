//
//  FirebaseAuthManager.swift
//  TQM
//
//  Created by Diego De Dios on 10/15/23.
//

import FirebaseAuth

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    private init() {}
    
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
    
    // Log in with email + password
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
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
