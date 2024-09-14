//
//  UIStackView.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit

public extension UIStackView {
    @discardableResult func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
    
    @discardableResult
    func removeAllArrangedSubviews(except view: UIView) -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            if subview == view {
                return removedSubviews
            }
            removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
    
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }
    
    func addArrangeSubViewIfNotExist(_ view: UIView) {
        if !self.arrangedSubviews.contains(view) {
            self.addArrangedSubview(view)
        }
    }

    // Adds a background view to the stackview with the desired color and applies some corner radius
    func addBackground(_ color: UIColor, cornerRadius: CGFloat = 10.0) {
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = color
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(backgroundView, at: 0)
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.masksToBounds = true
        backgroundView.clipsToBounds = true
    }
}
