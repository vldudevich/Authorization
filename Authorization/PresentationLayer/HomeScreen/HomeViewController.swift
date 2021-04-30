//
//  HomeViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Static members
    // MARK: - Enums
    // MARK: - Overrides
    // MARK: - Outlets
    @IBOutlet private weak var homeScreenLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    // MARK: - Constants
    private let homeScreenViewModel: HomeScreenViewModel
    
    // MARK: - Properties
    // MARK: - Lifecycle
    init(homeScreenViewModel: HomeScreenViewModel) {
        self.homeScreenViewModel = homeScreenViewModel
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Private extension
private extension HomeViewController {
    
    func setupUI() {
        homeScreenLabel.text = "Welcome to Authorization Project. Congratulations!"
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        Decorator.HomeScreen.Button.decorateButton(button: logoutButton, title: "Logout", backgroundColor: .systemBlue, tintColor: .white)
    }
    
    @objc
    func didTapLogout() {
        homeScreenViewModel.onSuccessLogout = { [weak self] in
            self?.view.window?.switchRootViewController(to: UINavigationController(rootViewController: AuthorizationViewController()), animated: false, duration: 0.3, options: .allowAnimatedContent, nil)
            self?.hideLoadingFace()
        }
        homeScreenViewModel.onFailedLogout = { [weak self] _ in
            self?.showAlert(title: "Erros", message: "some error")
            self?.hideLoadingFace()
        }
        showLoadingFace()
        homeScreenViewModel.logout()
    }
}
