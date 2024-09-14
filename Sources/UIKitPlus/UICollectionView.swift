//
//  UICollectionView.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit

public extension UICollectionView {
    
    func deque<cell: UICollectionViewCell>(_ cell: cell.Type, index: IndexPath) -> cell {
        return dequeueReusableCell(withReuseIdentifier: cell.className, for: index) as! cell
    }
    
    func dequeHeader<view: UICollectionReusableView>(_ view: view.Type, index: IndexPath) -> view {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.className, for: index) as! view
    }
    
    func dequeFooter<view: UICollectionReusableView>(_ view: view.Type, index: IndexPath) -> view {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: view.className, for: index) as! view
    }
    
    func register(nib nibName: String, bundle: Bundle? = nil) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    func register(nibs nibNames: [String], bundle: Bundle? = nil) {
        nibNames.forEach {
            register(UINib(nibName: $0, bundle: bundle), forCellWithReuseIdentifier: $0)
        }
    }
    
    func registerSectionHeader(nib nibName: String, bundle: Bundle? = nil) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName)
    }
    
    func registerSectionFooter(nib nibName: String, bundle: Bundle? = nil) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibName)
    }
    
}
