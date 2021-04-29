//
//  DataManager.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import UIKit
import Firebase

class DataManager {
    private var dataBaseManager = DatabaseManager()
}

extension DataManager {
    
    func userExist(email: String, completion: @escaping ((Bool) -> Void)) {
        dataBaseManager.userExists(with: email) { exist in
            completion(exist)
        }
    }
    
    func insertUser(with user: User, completion: @escaping ((Bool) -> Void)) {
        dataBaseManager.insertUser(with: user) { exist in
            completion(exist)
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            completion(.success(Void()))
        }
        catch {
            completion(.failure(Errors.noLogout))
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let result = authResult else {
                completion(.failure(Errors.badFormatEmail))
                return }
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(result))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let result = authResult else {
                completion(.failure(Errors.badFormatEmail))
                return }
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(result))
            }
        }
    }
}
