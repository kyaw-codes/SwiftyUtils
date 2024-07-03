//
//  DateTests.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 03/07/2024.
//

import Testing
import Foundation
import SwiftPlus

struct DateTests {
  
  @Test func toString() async throws {
    let dateStr = "2024-02-24"
    let date = convert(dateStr, toDate: "yyyy-MM-dd")
    #expect(date?.toString() == dateStr)
  }
  
  // MARK: helper
  func convert(_ dateStr: String, toDate format: String) -> Date? {
    let df = DateFormatter()
    df.dateFormat = format
    return df.date(from: dateStr)
  }
}
