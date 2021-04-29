//
//  AuthorizationViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit

class AuthorizationViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    // MARK: - Constants

    // MARK: - Properties
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}

// MARK: Private extension
private extension AuthorizationViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        headerLabel.text = "Welcome to Authorization"
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        createAccountButton.setTitle("Create an account", for: .normal)
        createAccountButton.backgroundColor = .white
        createAccountButton.tintColor = .black
        createAccountButton.layer.cornerRadius = 12
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        createAccountButton.layer.borderWidth = 0.5
        createAccountButton.layer.borderColor = UIColor.lightGray.cgColor
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.tintColor = .white
        signInButton.layer.cornerRadius = 12
        signInButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    }
    
    @objc
    func didTapCreateAccount() {
        pushModule(RegistrationViewController())
    }
    
    @objc
    func didTapSignInButton() {
        pushModule(LoginViewController())
    }
}
