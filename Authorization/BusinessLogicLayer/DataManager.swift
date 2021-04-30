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
    
    func userExist(email: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        dataBaseManager.userExists(with: email) { exist in
            switch exist {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
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
    
    func signUp(email: String,
                password: String,
                firstName: String,
                lastName: String,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        dataBaseManager.userExists(with: email) { [weak self] result in
            
            switch result {
            case .success:
                completion(.failure(Errors.currentUserExist))
            case .failure:
                Firebase.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard let result = authResult else {
                        completion(.failure(Errors.badFormatEmail))
                        return }
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(result))
                        let user = User(firstName: firstName, lastName: lastName, emailAdress: email)
                        self?.dataBaseManager.insertUser(with: user) { success in
                            print("User add to database")
                        }
                    }
                }
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
