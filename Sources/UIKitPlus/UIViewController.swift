//
//  UIViewController.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//


import UIKit
import SafariServices
import MapKit
import CoreLocation

public extension UIViewController {
    func showShare(for pdf: Data) {
        let vc = UIActivityViewController(
            activityItems: [pdf],
            applicationActivities: nil
        )
        present(vc, animated: true)
    }

    func showShare(for pdf: URL, completion: @escaping (URL) -> Void) {
        let vc = UIActivityViewController(
            activityItems: [pdf],
            applicationActivities: nil
        )
        vc.completionWithItemsHandler = { _, _, _, _ in
            completion(pdf)
        }
        present(vc, animated: true)
    }


    func showShare(forLink link: String, templateText: String? = nil) {
        if let url = URL(string: link) {
            var sharingItems: [Any] = []
            if let text = templateText {
                sharingItems.append(text)
            }
            sharingItems.append(url)
            let vc = UIActivityViewController(
                activityItems: sharingItems,
                applicationActivities: nil)
            present(vc, animated: true)
        }
    }

    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }

    @objc func popVCToBottom() {
        navigationController?.popToBottom()
    }

    @objc func dismissVC(animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completionHandler)
    }

    @objc func dismissNavigation() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func popOrDismiss() {
        guard let nav = navigationController else {
            dismissVC()
            return
        }
        if nav.viewControllers.count > 1 {
            popVC()
        } else {
            dismissVC()
        }
    }

    var isPresentedModally: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar || false
    }

	func showAlert(title: String? = "", message: String?, actionTitle: String = "OK", actionCallback: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            actionCallback?()
        }))
        present(alertController, animated: true, completion: nil)
    }

    func showAlert(title: String? = "", message: String?, positiveTitle: String = "Yes", positiveAction: (() -> Void)? = nil, negativeTitle: String = "No", negativeAction:  (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: negativeTitle, style: .default, handler: { _ in
            if negativeAction == nil { alertController.dismiss(animated: true, completion: nil) }
            negativeAction?()
        }))

        alertController.addAction(UIAlertAction(title: positiveTitle, style: .default, handler: { _ in
            if positiveAction == nil { alertController.dismiss(animated: true, completion: nil) }
            positiveAction?()
        }))

        present(alertController, animated: true, completion: nil)
    }

    func showInputAlert(title: String? = "", message: String? = "", submitAction: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = message
            textField.clearButtonMode = .whileEditing
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })

        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] _ in
            let inputText = alert?.textFields![0].text ?? "" // Force unwrapping because we know it exists.
            submitAction?(inputText)
            alert?.dismiss(animated: true, completion: nil)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    func openURL(_ url: String) {
        if let url = URL(string: url) {
            if #available(iOS 11.0, *) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true)
            } else {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }

    func openURLInSafari(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    func replaceRootVC(
        with vc: UIViewController,
        duration: TimeInterval = 0.4,
        options: UIView.AnimationOptions = .transitionCrossDissolve
    ) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        window.rootViewController = vc
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }

    @objc
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    func call(phone no: String) {
        guard let url = URL(string: "tel://\(no)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    static func canOpenGoogleMap() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
    }

    static func canOpenAppleMap() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "http://maps.apple.com/maps")!)
    }

    func openGoogleMap(with coordinate: (lat: String, long: String)) {
         guard let url = URL(string: "comgooglemaps://?q=\(coordinate.lat),\(coordinate.long)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func openAppleMap(with coordinate: (lat: Double?, long: Double?), name: String?) {
        let coordinate = CLLocationCoordinate2DMake(coordinate.lat ?? 0, coordinate.long ?? 0)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }

    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func openAppStore(using url: String) {
        guard let url = URL(string: url) else {
            print("invalid app store url")
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("can't open app store url")
        }
    }

    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("can't open app store url")
        }
    }

    func openAppSetting() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString + (Bundle.main.bundleIdentifier ?? "")) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            } else {
                print("can't open app setting")
            }
        } else {
            print("can't open app setting")
        }
    }

    func showSettingsAlert(title: String, message: String) {
        if let appSettingURL = URL(string: UIApplication.openSettingsURLString) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .cancel, handler: { _ -> Void in
                UIApplication.shared.open(appSettingURL, options: [:], completionHandler: nil)
            }))
            present(alert, animated: true)
        }
    }

    func present(
        _ vc: UIViewController,
        style: UIModalPresentationStyle = .overFullScreen,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        vc.modalPresentationStyle = style
        self.present(vc, animated: animated, completion: completion)
    }

    @discardableResult
    func wrapInsideNav(isNavigationBarHidden: Bool = true) -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.isNavigationBarHidden = isNavigationBarHidden
        return nav
    }
    
    func call(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

public extension UIViewController {
    func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        } else {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func showAlert(title: String? = "", message: String?, isMsgBold: Bool?, isPreferAction: Bool?, actionCallback: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            actionCallback?()
        })
        alertController.addAction(action)

        if let isMsgBold = isMsgBold, isMsgBold {
            let attributedText = NSMutableAttributedString(string: message ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)])
            alertController.setValue(attributedText, forKey: "attributedMessage")
        }

        if let isPreferAction = isPreferAction, isPreferAction {
            alertController.preferredAction = action
        }

        present(alertController, animated: true, completion: nil)
    }

    func showAlert(title: String? = "", message: String? = "", btnFirstTitle: String? = nil, btnFirstAction: (() -> Void)? = nil, btnSecondTitle: String? = nil, btnSecondAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let btnFirstTitle = btnFirstTitle {
            alertController.addAction(UIAlertAction(title: btnFirstTitle, style: .default, handler: { _ in
                btnFirstAction?()
            }))
        }
        if let btnSecondTitle = btnSecondTitle {
            alertController.addAction(UIAlertAction(title: btnSecondTitle, style: .default, handler: { _ in
                btnSecondAction?()
            }))
        }
        if btnFirstTitle != nil || btnSecondTitle != nil {
            present(alertController, animated: true, completion: nil)
        }
    }

    func showAlert(title: String? = "", message: String?, firstBtnText: String, secondBtnText: String, firstActionCallback: (() -> Void)? = nil, secondActionCallback: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: firstBtnText, style: .default, handler: { _ in
            firstActionCallback?()
        }))
        alertController.addAction(UIAlertAction(title: secondBtnText, style: .default, handler: { _ in
            secondActionCallback?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
