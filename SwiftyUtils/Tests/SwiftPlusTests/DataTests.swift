//
//  DataTests.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 03/07/2024.
//

import Testing
import Foundation
import SwiftPlus

struct DataTests {
  
  @Test func convertsDataToString() async throws {
    let inputString = "Hello, World!"
    let inputData = inputString.data(using: .utf8)
    #expect(inputData?.string == inputString)
  }
  
}
