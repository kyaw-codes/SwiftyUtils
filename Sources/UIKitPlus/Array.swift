//
//  File.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 03/09/2024.
//

import UIKit

public extension Array {
  mutating func appendAndGetIndexPath(_ elements: [Element]) -> [IndexPath] {
      let currentLastIndex = count
      append(contentsOf: elements)
      let newIndexs = elements
          .enumerated()
          .map { index, _ in
            IndexPath(item: currentLastIndex + index, section: 0)
          }
      return newIndexs
  }
}
