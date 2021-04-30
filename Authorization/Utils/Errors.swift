//
//  Errors.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import Foundation

enum Errors: Error {
    
    case badFormatEmail
    case noUserId
    case noUserToken
    case noFullFillProfile
    case noLogout
    case failedInsertToBD
    case failedGetFromBD
    case currentUserExist
    
    var errorText: String {
        switch self {
        case .badFormatEmail:
            return "The email address is badly formatted"
        case .noUserId:
            return "Device ID not obtained"
        case .noUserToken:
            return "User token not obtained"
        case .noFullFillProfile:
            return "Please fill all field"
        case .noLogout:
            return "Failed to logout"
        case .failedInsertToBD:
            return "Failed insert User to BD"
        case .failedGetFromBD:
            return "Failed Get From BD"
        case .currentUserExist:
            return "Curent User Exist"
        }
    }
}
