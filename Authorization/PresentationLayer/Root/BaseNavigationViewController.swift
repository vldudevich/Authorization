////
////  BaseNavigationViewController.swift
////  Authorization
////
////  Created by Vladislav Dudevich on 29.04.2021.
////
//
//import UIKit
//
//// MARK: - Navigation Controller Data Source Protocol
//protocol NavigationBarDataSource: AnyObject {
//    
//    var barTitle: String? { get }
//    var barTitleView: UIView? { get }
//    var isLargeTitlePreferred: Bool { get }
//    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get }
//    
//    func backItem(for navigationBar: UINavigationBar) -> UIBarButtonItem?
//    func leftItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]?
//    func rightItems(for navigationBar: UINavigationBar) -> [UIBarButtonItem]?
//}
//
//// MARK: - Navigation Controller Style Data Source Protocol
//protocol NavigationBarStyleDataSource: AnyObject {
//    
//    var isDefaultBackButtonHidden: Bool { get }
//    var isNavigationBarHidden: Bool { get }
//    var isBackActionAnimated: Bool { get }
//    var isLargeTitlePreferred: Bool { get }
//    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get }
//    var barStyle: BaseNavigationViewController.NavigationBarStyle { get }
//}
//
//class BaseNavigationViewController: UINavigationController {
//    
//    // MARK: - Navigation bar Style
//    enum NavigationBarStyle: Int {
//        case transparent
//        case shadowed
//        case solid
//        case gradient
//    }
//    
//    // MARK: - Overrides
//    override  var childForStatusBarStyle: UIViewController? {
//        return topViewController
//    }
//    
//    // MARK: - Properties
//    override var viewControllers: [UIViewController] {
//        didSet {
//            performNeedsUpdates()
//        }
//    }
//    
//    override  var previewActionItems: [UIPreviewActionItem] {
//        return topViewController?.previewActionItems ?? []
//    }
//    
//    weak var barDataSource: NavigationBarDataSource? {
//        didSet {
//            reloadBarDataSource()
//        }
//    }
//    
//    weak var barStyleDataSource: NavigationBarStyleDataSource? {
//        didSet {
//            reloadBarStyle()
//        }
//    }
//    
//    func reloadBarStyle() {
//        
//        guard let barStyleDataSource = barStyleDataSource else { return }
//        
//        navigationBar.isHidden = barStyleDataSource.isNavigationBarHidden
//        
//        guard let last = self.viewControllers.last else { return }
//        last.navigationItem.hidesBackButton = barStyleDataSource.isDefaultBackButtonHidden
//        
//        navigationBar.titleTextAttributes = titleTextAttributes
//        navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
//        
//        //        navigationBar.barTintColor = barStyleDataSource.barTintColor
//        //        navigationBar.tintColor = barStyleDataSource.tintColor
//        //        navigationBar.backgroundColor = barStyleDataSource.navigationBarColor
//        //        navigationBar.titleTextAttributes = [.font: barStyleDataSource.barTitleFont,
//        //        .foregroundColor: barStyleDataSource.barTitleColor]
//        //
//        //        let backgroundImage = UIImage(color: barStyleDataSource.navigationBarColor)
//        //
//        switch barStyleDataSource.barStyle {
//        
//        case .transparent:
//            navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.backgroundColor = .clear
//            navigationBar.isTranslucent = true
//        case .shadowed:
//            navigationBar.isTranslucent = false
//            // navigationBar.setBackgroundImage(backgroundImage, for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
//            navigationBar.layer.shadowRadius = 4
//            navigationBar.layer.shadowColor = UIColor.black.cgColor
//            navigationBar.layer.shadowOpacity = 0.1
//            navigationBar.layer.masksToBounds = false
//        case .solid:
//            navigationBar.isTranslucent = false
//            navigationBar.barStyle = .blackTranslucent
//            // navigationBar.setBackgroundImage(backgroundImage, for: .default)
//            // navigationBar.setBackgroundImage(backgroundImage, for: .compactPrompt)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.layer.shadowOpacity = 0.0
//        case .gradient:
//            navigationBar.isTranslucent = true
//            var navigationFrame = navigationBar.bounds
//            if #available(iOS 11.0, *) {
//                
//                navigationFrame.size.height += view.safeAreaInsets.top
//            } else {
//                
//                navigationFrame.size.height += topLayoutGuide.length
//            }
////            guard let image = gradientImage(for: navigationFrame,
////                                            with: barStyleDataSource.navigationBarColor) else { return }
////            navigationBar.setBackgroundImage(image, for: .default)
//            navigationBar.shadowImage = UIImage()
//        }
//    }
//    
//    func reloadBarDataSource() {
//        
//        navigationBar.prefersLargeTitles = self.barDataSource?.isLargeTitlePreferred ?? false
//        navigationItem.largeTitleDisplayMode = self.barDataSource?.largeTitleDisplayMode ?? .never
//        
//        guard let last = viewControllers.last else { return }
//        
//        last.navigationItem.title = barDataSource?.barTitle
//        last.navigationItem.titleView = barDataSource?.barTitleView
//        last.navigationItem.leftBarButtonItems = barDataSource?.leftItems(for: navigationBar)
//        last.navigationItem.rightBarButtonItems = barDataSource?.rightItems(for: navigationBar)
//        
//        guard let backItem = barDataSource?.backItem(for: navigationBar) else { return }
//        
//        last.navigationItem.hidesBackButton = true
//        if last.navigationItem.leftBarButtonItems != nil {
//            last.navigationItem.leftBarButtonItems?.insert(backItem, at: 0)
//        } else {
//            last.navigationItem.leftBarButtonItems = [backItem]
//        }
//    }
//    
//    // MARK: - Private methods
//    private func performNeedsUpdates() {
//        reloadBarStyle()
//        reloadBarDataSource()
//    }
//    
//    private func gradientImage(for frame: CGRect, with color: UIColor) -> UIImage? {
//        
//        let gradient = CAGradientLayer()
//        gradient.startPoint = .zero
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.frame = frame
//        gradient.colors = [color.cgColor, color.withAlphaComponent(0.01).cgColor]
//        
//        UIGraphicsBeginImageContext(gradient.frame.size)
//        gradient.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return image
//    }
//}
