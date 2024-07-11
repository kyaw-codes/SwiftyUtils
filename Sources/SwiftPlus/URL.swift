//
//  URL.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 02/07/2024.
//

import Foundation

@available(iOS, deprecated: 16.0, message: "Use the built-in API instead")
public extension URL {
  static var documentsDirectory: Self {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
}
