//
//  String.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import Foundation

extension String {
    
    func firebaseString() -> String {
        var safeEmail = self.replacingOccurrences(of: ".", with: "-")
        safeEmail = self.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
