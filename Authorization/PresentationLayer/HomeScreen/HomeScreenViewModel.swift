//
//  HomeScreenViewModel.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import Foundation

class HomeScreenViewModel {
    
    private var dataManager = DataManager()
    
    var firstName = ""
    var lastName = ""
    var onSuccessLogout: (() -> Void)?
    var onFailedLogout: ((Error) -> Void)?
    
    
    func logout() {
        dataManager.logout { [weak self] result in
            switch result {
            case .success:
                self?.onSuccessLogout?()
            case .failure(let error):
                self?.onFailedLogout?(error)
            }
        }
    }
}
