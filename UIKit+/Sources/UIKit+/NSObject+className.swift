//
//  NSObject+className.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

#if canImport(UIKit)
import UIKit

public extension NSObject {
  /// Returns the name of the class as a String
  class var className: String {
    return String(describing: self)
  }
  
  /// Returns the name of the class as a String
  var className: String {
    return String(describing: type(of: self))
  }
}

#endif
