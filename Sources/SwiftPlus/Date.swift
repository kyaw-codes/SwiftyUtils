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
  
  // MARK: Need documentation and UTs

  var isToday: Bool {
    let gregorian = Calendar(identifier: .gregorian)
    let thisDate = gregorian.dateComponents([.day, .month, .year], from: self)
    let currentDate = gregorian.dateComponents([.day, .month, .year], from: Date())
    return thisDate == currentDate
  }
  
  var day: Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: self)
    return components.day ?? 1
  }
  
  /// As in MON, TUE
  var dayString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    let day = formatter.string(from: self)
    return day.uppercased()
  }
  
  var monthAndYear: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM yyyy"
    let month = formatter.string(from: self)
    return month
  }
  
  var month: Int {
    let component = Calendar.current.dateComponents([.month], from: self)
    return component.month ?? -1
  }
  
  var year: Int {
    let component = Calendar.current.dateComponents([.year], from: self)
    return component.year ?? -1
  }
  
  var monthLong: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    let month = formatter.string(from: self)
    return month
  }
  
  var nextMonthFirstDay: String{
    let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month,.year], from: nextMonth!)
    return "\(components.year ?? 0)-\(components.month ?? 0 )-\(1)"
  }
  
  var previousDay: Date {
    let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
    return previousDate ?? Date()
  }

  var nextDay: Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: self, wrappingComponents: true) ?? self
  }
  
  static var currentUTCTime: String? {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "UTC")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return formatter.string(from: Date())
  }
  
  func formatted(_ components: FormatterComponent...) -> String {
    let dateFormatter = DateFormatter()
    var dateFormat: String = ""
    for (index, component) in components.enumerated() {
      dateFormat = index == .zero ?
      component.rawValue :
      dateFormat + component.rawValue
    }
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
  
  enum FormatterComponent: String, CaseIterable {
      /// "3" for "2024-09-03"
      case dayOfMonth = "d"
      
      /// "03" for "2024-09-03"
      case dayOfMonthPadding = "dd"
      
      /// "1" for the first Thursday in the month
      case dayOfWeekInMonth = "F"
      
      /// "Tue" for "Tuesday"
      case dayOfWeekAbbreviationName = "E"
      
      /// "Tuesday" for "Tuesday"
      case dayOfWeekWideName = "EEEE"
      
      /// "T" for "Tuesday"
      case dayOfWeekNarrowName = "EEEEE"
      
      /// "Tu" for "Tuesday"
      case dayOfWeekShortName = "EEEEEE"
      
      /// "9" for "September"
      case monthOfYearSingle = "M"
      
      /// "09" for "September"
      case monthOfYearDouble = "MM"
      
      /// "Sep" for "September"
      case monthOfYearShorthandName = "MMM"
      
      /// "September" for "September"
      case monthOfYearFullName = "MMMM"
      
      /// "S" for "September"
      case monthOfYearNarrowName = "MMMMM"
      
      /// "2024" for "2024"
      case yearFullDigits = "yyyy"
      
      /// "24" for "2024"
      case yearTwoDigits = "yy"
      
      /// "3" for 3 PM
      case hour12 = "h"
      
      /// "03" for 3 PM
      case hour12Padding = "hh"
      
      /// "15" for 3 PM
      case hour24 = "H"
      
      /// "15" for 3 PM with padding
      case hour24Padding = "HH"
      
      /// "PM" for 3 PM
      case meridiem = "a"
      
      /// "9" for 9 minutes
      case minute = "m"
      
      /// "09" for 9 minutes with padding
      case minutePadding = "mm"
      
      /// "7" for 7 seconds
      case second = "s"
      
      /// "07" for 7 seconds with padding
      case secondPadding = "ss"
      
      /// "123" for 123 milliseconds
      case millisecond = "SSS"
      
      /// "-" for a dash
      case dash = "-"
      
      /// "." for a dot
      case dot = "."
      
      /// ":" for a colon
      case colon = ":"
      
      /// "," for a comma
      case comma = ","
      
      /// "_" for an underscore
      case underscore = "_"
      
      /// " " for a whitespace
      case whitespace = " "
  }
  
  func add(days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self) ?? .init()
  }
  
  func add(months: Int) -> Date {
    return Calendar.current.date(byAdding: .month, value: months, to: self) ?? .init()
  }
  
  func add(years: Int) -> Date {
    return Calendar.current.date(byAdding: .year, value: years, to: self) ?? .init()
  }
  
  func add(hours: Int) -> Date {
    return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? .init()
  }

  func add(minutes: Int) -> Date {
    return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? .init()
  }

  func add(seconds: Int) -> Date {
    return Calendar.current.date(byAdding: .second, value: seconds, to: self) ?? .init()
  }

  func timeAgoDisplay() -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date())
  }
  
  func toString(_ format: String = "dd-MM-yyyy", setLocalTimeZone: Bool = false) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = setLocalTimeZone ? .current : TimeZone(secondsFromGMT: 0)
    return formatter.string(from: self)
  }
  
  func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String? = nil) -> Date? { //"UTC"
    let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    let cal = Calendar.current
    var components = cal.dateComponents(x, from: self)
    
    if let tz = timeZoneAbbrev {
      components.timeZone = TimeZone(abbreviation: tz)
    }
    components.hour = hour
    components.minute = min
    components.second = sec
    
    return cal.date(from: components)
  }
}
