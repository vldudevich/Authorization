//
//  LoginViewController.swift
//  Authorization
//
//  Created by Vladislav on 28.04.2021.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: - Constants
    private let loginViewModel: LoginViewModel
    
    // MARK: - Properties
    private var emailFieldObserver: Cancellable?
    private var passwordFieldObserver: Cancellable?
    
    // MARK: - Lifecycle
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        emailFieldObserver = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: emailField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .sink(receiveValue: { text in
                self.loginViewModel.email = text
                self.updateStateLoginButton()
            })
        
        passwordFieldObserver = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .sink(receiveValue: { text in
                self.loginViewModel.password = text
                self.updateStateLoginButton()
            })
        updateStateLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Private extension
private extension LoginViewController {
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        Decorator.SignScreen.TextField.decorateTextField(textField: emailField,
                                    placeholderName: "Email",
                                    returnType: .next)
        Decorator.SignScreen.TextField.decorateTextField(textField: passwordField,
                                    placeholderName: "Password",
                                    returnType: .done,
                                    isSecure: true)
        navigationItem.title = "Sign in"
        Decorator.SignScreen.Button.decorateButton(button: loginButton,
                                                   title: "Login",
                                                   backgroundColor: .systemGreen,
                                                   tintColor: .white)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    @objc
    func didTapLogin() {
        loginViewModel.onSuccessLogin = { [weak self] in
            self?.view.window?.switchRootViewController(to: HomeViewController(homeScreenViewModel: HomeScreenViewModel()), animated: false, duration: 0.3, options: .allowAnimatedContent, nil)
            self?.hideLoadingFace()
        }
        loginViewModel.onFailedLogin = { [weak self] error in
            if error as! Errors == Errors.badFormatEmail {
                self?.showAlert(title: "Error", message: "Invalid email or password")
            }
            self?.hideLoadingFace()
        }
        showLoadingFace()
        loginViewModel.login()
        view.endEditing(true)
    }
    
    func updateStateLoginButton() {
        loginButton.isEnabled = !loginViewModel.email.isEmpty && !loginViewModel.password.isEmpty
        if loginButton.isEnabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
}
