//
//  RegistrationViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let scrollSubView = UIView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        return button
    }()
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private extension
private extension RegistrationViewController {
    
    func setupUI() {
        
        title = "Registration"
        
        emailField.delegate = self
        passwordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        

        view.addSubview(scrollView)
        
        scrollView.addSubview(scrollSubView)
        scrollView.backgroundColor = .white
        scrollSubView.isUserInteractionEnabled = true
        
        scrollSubView.addSubview(emailField)
        scrollSubView.addSubview(passwordField)
        scrollSubView.addSubview(firstNameField)
        scrollSubView.addSubview(lastNameField)
        scrollSubView.addSubview(registerButton)
        
        Decorator.decorateTextField(textField: emailField, placeholderName: "Email", returnType: .next)
        Decorator.decorateTextField(textField: passwordField, placeholderName: "Password", returnType: .next, isSecure: true)
        Decorator.decorateTextField(textField: firstNameField, placeholderName: "FirstName", returnType: .next)
        Decorator.decorateTextField(textField: lastNameField, placeholderName: "LastName", returnType: .done)
        
        setConstarints()
    }
    
    func setConstarints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor)
        
        scrollSubView.anchor(top: scrollView.topAnchor,
                      left: scrollView.leftAnchor,
                      bottom: scrollView.bottomAnchor,
                      right: scrollView.rightAnchor,
                      width: scrollView.widthAnchor,
                      height: scrollView.heightAnchor)
        
        emailField.anchorCenterXToSuperview()
        emailField.anchor(top: scrollSubView.safeAreaLayoutGuide.topAnchor,
                          left: scrollSubView.leftAnchor,
                          right: scrollSubView.rightAnchor,
                          topConstant: 16,
                          leftConstant: 32,
                          rightConstant: 32,
                          heightConstant: 50)
        
        passwordField.anchorCenterXToSuperview()
        passwordField.anchor(top: emailField.bottomAnchor,
                             left: scrollSubView.leftAnchor,
                             right: scrollSubView.rightAnchor,
                             topConstant: 16,
                             leftConstant: 32,
                             rightConstant: 32,
                             heightConstant: 50)
        
        firstNameField.anchorCenterXToSuperview()
        firstNameField.anchor(top: passwordField.bottomAnchor,
                              left: scrollSubView.leftAnchor,
                              right: scrollSubView.rightAnchor,
                              topConstant: 16,
                              leftConstant: 32,
                              rightConstant: 32,
                              heightConstant: 50)
        
        lastNameField.anchorCenterXToSuperview()
        lastNameField.anchor(top: firstNameField.bottomAnchor,
                             left: scrollSubView.leftAnchor,
                             right: scrollSubView.rightAnchor,
                             topConstant: 16,
                             leftConstant: 32,
                             rightConstant: 32,
                             heightConstant: 50)
        
        registerButton.anchorCenterXToSuperview()
        registerButton.anchor(top: lastNameField.bottomAnchor,
                              left: scrollSubView.leftAnchor,
                              right: scrollSubView.rightAnchor,
                              topConstant: 16,
                              leftConstant: 64,
                              rightConstant: 64,
                              heightConstant: 50)
    }
    
    @objc
    func didTapRegisterButton() {
        
    }
}

// MARK: - TextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
}
