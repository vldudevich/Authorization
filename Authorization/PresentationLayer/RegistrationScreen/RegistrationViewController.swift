//
//  RegistrationViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit
import Combine

class RegistrationViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var firstNameField: UITextField!
    @IBOutlet private weak var lastNameField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!

    // MARK: - Constants
    
    private let registrationViewModel: RegistrationViewModel
    
    // MARK: - Properties
    private var emailFieldObserver: Cancellable?
    private var passwordFieldObserver: Cancellable?
    // MARK: - Lifecycle
    
    init(registrationViewModel: RegistrationViewModel) {
        self.registrationViewModel = registrationViewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: Private extension
private extension RegistrationViewController {
    
    func setupUI() {
        
        title = "Sign up"
        view.backgroundColor = .white
        
        Decorator.RegistrationScreen.TextField.decorateTextField(textField: emailField, placeholderName: "Email", returnType: .next)
        Decorator.RegistrationScreen.TextField.decorateTextField(textField: passwordField, placeholderName: "Password", returnType: .next, isSecure: true)
        Decorator.RegistrationScreen.TextField.decorateTextField(textField: firstNameField, placeholderName: "FirstName", returnType: .next)
        Decorator.RegistrationScreen.TextField.decorateTextField(textField: lastNameField, placeholderName: "LastName", returnType: .done)
        
        registerButton.setTitle("Sign Up", for: .normal)
        Decorator.SignScreen.Button.decorateButton(button: registerButton,
                                                   title: "Sign up",
                                                   backgroundColor: .systemGreen,
                                                   tintColor: .white)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        setObservers()
    }
    
    @objc
    func didTapRegisterButton() {
        registrationViewModel.onSuccessRegistration =  { [weak self] in
            self?.view.window?.switchRootViewController(to: HomeViewController(homeScreenViewModel: HomeScreenViewModel()), animated: false, duration: 0.3, options: .beginFromCurrentState, nil)
            self?.hideLoadingFace()
        }
        registrationViewModel.onFailedRegistration = { [weak self] error in
            self?.showAlert(title: "Error", message: "Invalid email or password")
            self?.hideLoadingFace()
        }
        showLoadingFace()
        registrationViewModel.signUp()
        view.endEditing(true)
    }
    
    func setObservers() {
        emailFieldObserver = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: emailField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .sink(receiveValue: { text in
                self.registrationViewModel.email = text
                self.updateStateRegistrationButton()
            })
        
        passwordFieldObserver = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .sink(receiveValue: { text in
                self.registrationViewModel.password = text
                self.updateStateRegistrationButton()
            })
    }
    
    func updateStateRegistrationButton() {
        registerButton.isEnabled = !registrationViewModel.email.isEmpty && !registrationViewModel.password.isEmpty
        if registerButton.isEnabled {
            registerButton.alpha = 1.0
        } else {
            registerButton.alpha = 0.5
        }
    }
}
