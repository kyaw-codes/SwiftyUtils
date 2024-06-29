//
//  NSObjectTests.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 29/06/2024.
//

import Testing
import Foundation
@testable import UIKit_

struct NSObjectTests {

    @Test func className() async throws {
      class TestClass: NSObject {}
      #expect(TestClass.className == "TestClass")
      #expect(TestClass().className == "TestClass")
    }

}
