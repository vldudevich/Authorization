//
//  LoginViewModel.swift
//  Authorization
//
//  Created by Vladislav on 29.04.2021.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Constants
    private let dataManager = DataManager()
    
    // MARK: - Properties
    var email = ""
    var password = ""
    var onSuccessLogin: (() -> Void)?
    var onFailedLogin: ((Error) -> Void)?
    
    func login() {
        dataManager.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                Logger.log(authResult.user)
                self?.onSuccessLogin?()
            case .failure(let error):
                self?.onFailedLogin?(error)
            }
        }
    }
}
