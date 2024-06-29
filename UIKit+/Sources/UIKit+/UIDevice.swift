//
//  UIDevice.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

#if canImport(UIKit)
import UIKit

public extension UIDevice {
  /// Returns `true` if the device has a notch
  var hasNotch: Bool {
    guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
    if UIDevice.current.orientation.isPortrait {
      return window.safeAreaInsets.top >= 44
    } else {
      return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
    }
  }
}
#endif
