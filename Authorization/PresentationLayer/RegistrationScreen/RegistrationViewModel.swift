//
//  RegistrationViewModel.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import Foundation

class RegistrationViewModel {
    
    // MARK: - Constants
    private let dataManager = DataManager()
    
    // MARK: - Properties
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    
    var onSuccessRegistration: (() -> Void)?
    var onFailedRegistration: ((Error) -> Void)?
    
    func signUp() {
        dataManager.signUp(email: email,
                           password: password,
                           firstName: firstName,
                           lastName: lastName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.onSuccessRegistration?()
            case .failure(let error):
                self.onFailedRegistration?(error)
            }
        }
    }
}
