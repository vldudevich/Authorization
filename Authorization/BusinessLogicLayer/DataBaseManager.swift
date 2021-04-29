//
//  DataBaseManager.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    private let database = Database.database().reference()
    
    func safeEmail(emailAddress: String) -> String {
        return emailAddress.firebaseString()
    }
    
    func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        database.child(email.firebaseString()).observeSingleEvent(of: .value, with: { (snapshot) in
            guard snapshot.value as? String != nil else { completion(false); return }
            
            completion(true)
        })
    }
    
    func insertUser(with user: User, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { error, _ in
            guard error == nil else {
                Logger.log(Errors.failedInsertToBD)
                completion(false)
                return
            }
            
            self.database.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    let newElement = [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                    if !usersCollection.contains(newElement) {
                        usersCollection.append(newElement)
                    }
                    self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                        guard error == nil else { completion(false); return }
                        completion(true)
                    })
                }
                else {
                    let newCollection: [[String: String]] = [
                        ["name": user.firstName + " " + user.lastName,
                         "email": user.safeEmail
                        ]
                    ]
                    self.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else { completion(false); return }
                        completion(true)
                    })
                }
            })
            completion(true)
        }
    }
    
    func removeDB() {
        database.removeAllObservers()
    }
    
    func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(Errors.failedGetFromBD))
                return
            }
            completion(.success(value))
            
        })
    }
}

struct User {
    
    let firstName: String
    let lastName: String
    let emailAdress: String
    
    var safeEmail: String {
        return emailAdress.firebaseString()
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture_name.png"
    }
}
