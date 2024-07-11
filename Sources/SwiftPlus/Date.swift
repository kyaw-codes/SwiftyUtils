//
//  Date.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 03/07/2024.
//

import Foundation

public extension Date {
  
  /**
  Converts a Date object to a String representation based on a specified date format.
  - Parameter format: The date format string used to format the `Date` object. Defaults to "yyyy-MM-dd".
  - Returns: A `String` representing the formatted date.
   
  This function can be used whenever you need to convert a Date object to a String representation with a specific format.
   
   ```swift
   let date = Date()
   let formattedDate = date.toString() // Default format "yyyy-MM-dd"
   print(formattedDate) // Output: "2024-06-30"

   let customFormattedDate = date.toString(format: "MMM dd, yyyy")
   print(customFormattedDate) // Output: "Jun 30, 2024"

   ```
   */
  func toString(format: String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
 
}
