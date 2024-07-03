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
  
  @Test func generateRandom() async throws {
    Task {
      let sixtyFourBytesData = Data.generateRandom()
      #expect(sixtyFourBytesData.count == 64)
    }
    
    Task {
      let sixteenBytesData = Data.generateRandom(16)
      #expect(sixteenBytesData.count == 16)
    }
  }
  
}
