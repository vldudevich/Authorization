//
//  BaseViewController.swift
//  Authorization
//
//  Created by Vladislav Dudevich on 28.04.2021.
//

import UIKit

class BaseViewController: UIViewController {
    private var loadFace: UIView?
}

extension BaseViewController: TransitionController {
    
    func addModuleAsChildAndFill(_ viewController: UIViewController) {
    }
    
    func presentModule(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func presentModuleOnTop(with viewController: UIViewController) {
    }
    
    func pushModule(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Dismiss current module
    /// If module is contained in `UINavigationController` and
    /// is not root controller, then function `popViewController` is called from `UINavigationController`.
    ///
    /// - Parameter animated: true to dismiss module animated
    /// - Parameter popToRoot: true to pop controllers to root
    /// - Parameter completion: Completion if available, *IMPORTANT* won't be called otherwise
    func dismissModule(animated: Bool, popToRoot: Bool, completion: @escaping () -> Void) {
        switch parent {
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty &&
                navigationController.viewControllers.first != self:
            if popToRoot {
                navigationController.popToRootViewController(animated: animated)
            } else {
                navigationController.popViewController(animated: animated)
            }
        case _ where parent?.presentingViewController != nil || parent?.popoverPresentationController != nil:
            dismiss(animated: animated, completion: completion)
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty:
            if popToRoot {
                navigationController.popToRootViewController(animated: animated)
            } else {
                navigationController.popViewController(animated: animated)
            }
        default:
            dismiss(animated: animated, completion: completion)
        }
    }
    
    /// Dismiss current module
    /// If module is contained in `UINavigationController` and
    /// is not root controller, then function `popViewController` is called from `UINavigationController`.
    ///
    /// - Parameter animated: true to dismiss module animated
    /// - Parameter popToRoot: true to pop controllers to root
    @objc
    func dismissModule(animated: Bool, popToRoot: Bool) {
        dismissModule(animated: animated, popToRoot: popToRoot, completion: { })
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        presentModule(alertController)
    }
    
    func showLoadingFace() {
        addLoadingFace()
    }
    
    func hideLoadingFace() {
        removeLoadingFace()
    }
}

// MARK: - Private extension
extension BaseViewController {
    
    func addLoadingFace() {
        
        guard loadFace == nil else { return }
        
        let blurEffect = UIBlurEffect(style: .regular)
        let backgroundView = UIVisualEffectView(effect: blurEffect)
        // backgroundView.backgroundColor = view.backgroundColor
        // backgroundView.alpha = 0.8
        
        view.addSubview(backgroundView)
        backgroundView.fillToSuperview()
        
        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        
        backgroundView.contentView.addSubview(activityIndicator)
        activityIndicator.anchorCenterSuperview()
        activityIndicator.startAnimating()
        
        loadFace = backgroundView
        // navigationController?.navigationBar.isUserInteractionEnabled = false
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
    
    func removeLoadingFace() {
        // loadFace?.alpha = 0.0
        loadFace?.removeFromSuperview()
        loadFace = nil
        // navigationController?.navigationBar.isUserInteractionEnabled = true
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        if #available(iOS 13.0, *) {
            isModalInPresentation = false
        }
    }
}
