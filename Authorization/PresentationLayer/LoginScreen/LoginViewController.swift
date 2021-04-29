//
//  LoginViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    
    // MARK: - Constants
    private let scrollView = UIScrollView()
    private let scrollSubView = UIView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        return button
    }()
    // MARK: - Properties
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private extension
private extension LoginViewController {
    
    func setupUI() {
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(scrollSubView)
        scrollSubView.addSubview(emailField)
        scrollSubView.addSubview(passwordField)
        scrollSubView.addSubview(loginButton)
        
        Decorator.decorateTextField(textField: emailField,
                                    placeholderName: "Email",
                                    returnType: .next)
        Decorator.decorateTextField(textField: passwordField,
                                    placeholderName: "Password",
                                    returnType: .done,
                                    isSecure: true)
        setConstraints()
        navigationItem.title = "Sign in"
    }
    
    func setConstraints() {
        
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
                          topConstant: 64,
                          leftConstant: 32,
                          rightConstant: 32,
                          heightConstant: 50)
        
        passwordField.anchorCenterXToSuperview()
        passwordField.anchor(top: emailField.bottomAnchor,
                          left: scrollSubView.leftAnchor,
                          right: scrollSubView.rightAnchor,
                          topConstant: 32,
                          leftConstant: 32,
                          rightConstant: 32,
                          heightConstant: 50)
        
        loginButton.anchorCenterXToSuperview()
        loginButton.anchor(top: passwordField.bottomAnchor,
                          left: scrollSubView.leftAnchor,
                          right: scrollSubView.rightAnchor,
                          topConstant: 48,
                          leftConstant: 64,
                          rightConstant: 64,
                          heightConstant: 50)
    }
    
    @objc
    func didTapLogin() {
        
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
}
