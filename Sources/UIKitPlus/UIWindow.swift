//
//  File.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit

public extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(_ viewController: UIViewController?) -> UIViewController? {
        if let navController = viewController as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(navController.visibleViewController)
            
        } else if let tabBarController = viewController as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController)
            
        } else if let presentedVC = viewController?.presentedViewController {
            return UIWindow.getVisibleViewControllerFrom(presentedVC)
            
        } else {
            return viewController
        }
    }
    
    func replaceRootVC(
        with vc: UIViewController,
        duration: TimeInterval = 0.4,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        completion: (() -> Void)? = nil
    ) {
        guard let view = rootViewController?.view else { return }
        rootViewController = vc
        
        UIView.transition(
            from: view,
            to: vc.view,
            duration: duration,
            options: options) { [weak self] finished in
            if let completion = completion {
                completion()
            }
            self?.rootViewController = vc
        }
    }
    
    var safeArea: (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            let windo = UIApplication.shared.delegate?.window
            return (top: windo??.safeAreaInsets.top ?? 20, bottom: windo??.safeAreaInsets.bottom ?? 0)
        }
        return (top: 20, bottom: 0)
    }
    
    func tabBarController(controller: UIViewController? = UIApplication.mainWindow?.rootViewController) -> UIViewController? {
        if let tabController = controller as? UITabBarController {
            return tabController
        }
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func topViewController(controller: UIViewController? = UIApplication.mainWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static func switchRootView(_ root: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        window.rootViewController = root
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}
