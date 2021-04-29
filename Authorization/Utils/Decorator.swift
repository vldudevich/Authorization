//
//  Decorator.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 29.04.2021.
//

import UIKit

enum Decorator { }

// MARK: - Decorator
extension Decorator {
    enum SignScreen { }
    enum RegistrationScreen { }
    enum HomeScreen {}
}

// MARK: - Decorator.SignScreen
extension Decorator.SignScreen {
    
    enum TextField {
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
    
    enum Button {
        static func decorateButton(button: UIButton,
                                   title: String,
                                   backgroundColor: UIColor,
                                   tintColor: UIColor) {
            button.setTitle(title, for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(tintColor, for: .normal)
            button.layer.cornerRadius = 12
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
}

// MARK: - Decorator.RegistrationScreen
extension Decorator.RegistrationScreen {
    enum TextField {
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
    enum Button {
        static func decorateButton(button: UIButton,
                                   title: String,
                                   backgroundColor: UIColor,
                                   tintColor: UIColor) {
            button.setTitle(title, for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(tintColor, for: .normal)
            button.layer.cornerRadius = 12
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
}

// MARK: - HomeScreen
extension Decorator.HomeScreen {
    enum Button {
        static func decorateButton(button: UIButton,
                                   title: String,
                                   backgroundColor: UIColor,
                                   tintColor: UIColor) {
            button.setTitle(title, for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(tintColor, for: .normal)
            button.layer.cornerRadius = 12
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
}
