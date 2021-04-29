//
//  Decorator.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import UIKit

class Decorator {
    
    private init() {}
    
    static func decorateTextField(textField: UITextField,
                                  placeholderName: String,
                                  returnType: UIReturnKeyType,
                                  isSecure: Bool = false) {
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = returnType
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .gray
        textField.attributedPlaceholder = NSAttributedString(string: placeholderName, attributes: [NSMutableAttributedString.Key.foregroundColor: UIColor.gray])
        textField.isSecureTextEntry = isSecure
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
    }
}
