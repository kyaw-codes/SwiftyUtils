//
//  UIApplication.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
  var appVersion: String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0.0"
  }
  
  var appVersionWithoutDot: String {
    return appVersion.replacingOccurrences(of: ".", with: "")
  }
  
}

#endif
