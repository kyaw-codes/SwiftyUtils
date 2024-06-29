//
//  NSObjectTests.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

import Testing
import Foundation
@testable import UIKitPlus

struct NSObjectTests {

  @Test("Check if NSObject's className extension returns the name of the class as a String.")
  func className() async throws {
    class TestClass: NSObject {}
    #expect(TestClass.className == "TestClass")
    #expect(TestClass().className == "TestClass")
  }
  
}
