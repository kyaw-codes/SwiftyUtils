//
//  Dictionary.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 03/09/2024.
//

import Foundation

// MARK: Need documentation and UTs

public extension Dictionary {
  mutating func swap(key1: Key, key2: Key) {
    if  let value = self[key1], let existingValue = self[key2] {
      self[key1] = existingValue
      self[key2] = value
    }
  }
}
