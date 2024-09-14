//
//  UIApplication.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
    
    static var mainWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

  var appVersion: String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0.0"
  }
  
  var appVersionWithoutDot: String {
    return appVersion.replacingOccurrences(of: ".", with: "")
  }
  
  /// Get the top most presented UIViewController
    class func topViewController(controller: UIViewController? = UIApplication.mainWindow?.rootViewController) -> UIViewController? {
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
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
