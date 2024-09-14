//
//  UITableView.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit
import SwiftPlus

public extension UITableView {
    
    func deque<cell: UITableViewCell>(_ cell: cell.Type) -> cell {
        return dequeueReusableCell(withIdentifier: cell.className) as! cell
    }
    
    func dequeHeaderFooter<T: UITableViewHeaderFooterView>(_ cell: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
    
    func register<cell: UITableViewCell>(_ cell: cell.Type) {
        register(cell, forCellReuseIdentifier: cell.className)
    }
    
    func register(nib nibName: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nibName , bundle: bundle), forCellReuseIdentifier: nibName)
    }
    
    func register(nib nibName: String, bundle: Bundle? = nil, forCellReuseIdentifier identifier: String) {
        self.register(UINib(nibName: nibName , bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooter(nib nibName: String, bundle: Bundle? = nil) {
        register(UINib(nibName: nibName , bundle: bundle), forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) {
        register(headerFooterView.self, forHeaderFooterViewReuseIdentifier: headerFooterView.className)
    }
    
    func register(nibs nibNames: [String], bundle: Bundle? = nil) {
        nibNames.forEach {
            self.register(UINib(nibName: $0 , bundle: bundle), forCellReuseIdentifier: $0)
        }
    }
    
    func register(nibs nibNames: [UITableViewCell], bundle: Bundle? = nil) {
        nibNames.forEach {
            self.register(UINib(nibName: $0.className , bundle: bundle), forCellReuseIdentifier: $0.className)
        }
    }
    
    func layoutHeaderView() {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
    func fitToContentHeight(heightConstraint: NSLayoutConstraint) {
        self.reloadData()
        heightConstraint.constant = 10000
        self.setNeedsLayout()
        self.layoutIfNeeded()
        heightConstraint.constant = self.contentSize.height
    }
}

public extension UITableViewCell {
    func addSeparator(color: UIColor, padding: CGFloat, height: CGFloat) {
        let frame = self.contentView.frame.size
        let separator = CALayer()
        separator.frame = CGRect(x: padding, y: frame.height - height, width: frame.width - (2 * padding), height: height)
        separator.backgroundColor = color.cgColor
        self.contentView.layer.addSublayer(separator)
    }
}

