//
//  Int.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

// MARK: Need documentation and UTs
public extension Int {
    
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var string: String {
        return String(self)
    }
    
    func toString(digit: Int = 2) -> String? {
        return String(format: "%0\(digit)d", self)
    }
    
    func secondToFormattedMinutes() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func secondToFormattedHour() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
    func secondToHour() -> (h: String?, m: String, s: String) {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            let value = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
                .split(separator: ":").compactMap { "\($0)" }
            return (value[0], value[1], value[2])
        } else {
            let value = String(format: "%02i:%02i", minutes, seconds).split(separator: ":").compactMap { "\($0)" }
            return (nil, value[0], value[1])
        }
    }
    
    func commaFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    /// Produces a getter function for a given key path. Useful for composing property access with functions.
    ///
    ///     get(\String.count)
    ///     // (String) -> Int
    ///
    /// - Parameter keyPath: A key path.
    /// - Returns: A getter function.
    func get<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
      return { root in root[keyPath: keyPath] }
    }

    /// Produces an immutable setter function for a given key path. Useful for composing property changes.
    ///
    /// - Parameter keyPath: A key path.
    /// - Returns: A setter function.
    func prop<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>
      )
      -> (@escaping (Value) -> Value)
      -> (Root) -> Root {

        return { update in
          { root in
            var copy = root
            copy[keyPath: keyPath] = update(copy[keyPath: keyPath])
            return copy
          }
        }
    }

    /// Produces an immutable setter function for a given key path and update function.
    ///
    /// - Parameters
    ///   - keyPath: A key path.
    ///   - update: An update function.
    /// - Returns: A setter function.
    func over<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>,
      _ update: @escaping (Value) -> Value
      )
      -> (Root) -> Root {

        return prop(keyPath)(update)
    }

    /// Produces an immutable setter function for a given key path and constant value.
    ///
    /// - Parameters:
    ///   - keyPath: A key path.
    ///   - value: A new value.
    /// - Returns: A setter function.
    func set<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>,
      _ value: Value
      )
      -> (Root) -> Root {

        return over(keyPath) { _ in value }
    }

    // MARK: - Mutation
    /// Produces an in-place setter function for a given key path. Useful for composing value property changes efficiently.
    ///
    /// - Parameter keyPath: A writable key path.
    /// - Returns: A mutable setter function.
    func mprop<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>
      )
      -> (@escaping (inout Value) -> Void)
      -> (inout Root) -> Void {

        return { update in
          { root in
            update(&root[keyPath: keyPath])
          }
        }
    }

    /// Uncurried `mver`. Takes a key path and update function all at once.
    ///
    /// - Parameters:
    ///   - keyPath: A writable key path.
    ///   - update: An update function for a given value.
    /// - Returns: A value-mutable setter function.
    func mver<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>,
      _ update: @escaping (inout Value) -> Void
      )
      -> (inout Root) -> Void {

        return mprop(keyPath)(update)
    }

    /// Produces a reference-mutable setter function for a given key path to a reference. Useful for composing reference property changes efficiently.
    ///
    /// - Parameter keyPath: A reference-writable key path.
    /// - Returns: A reference-mutable setter function.
    func mprop<Root, Value>(
      _ keyPath: ReferenceWritableKeyPath<Root, Value>
      )
      -> (@escaping (Value) -> Void)
      -> (Root) -> Void
      where Value: AnyObject {

        return { update in
          { root in
            update(root[keyPath: keyPath])
          }
        }
    }

    /// Uncurried `mver`. Takes a key path and update function all at once.
    ///
    /// - Parameters:
    ///   - keyPath: A reference-writable key path.
    ///   - update: An update function for a given value.
    /// - Returns: A reference-mutable setter function.
    func mverObject<Root, Value>(
      _ keyPath: ReferenceWritableKeyPath<Root, Value>,
      _ update: @escaping (Value) -> Void
      )
      -> (Root) -> Void
      where Value: AnyObject {

        return mprop(keyPath)(update)
    }

    /// Produces an reference-mutable setter function for a given key path to a value. Useful for composing reference property changes efficiently.
    ///
    /// - Parameter keyPath: A key path.
    /// - Returns: A setter function.
    func mprop<Root, Value>(
      _ keyPath: ReferenceWritableKeyPath<Root, Value>
      )
      -> (@escaping (inout Value) -> Void)
      -> (Root) -> Void {

        return { update in
          { root in
            update(&root[keyPath: keyPath])
          }
        }
    }

    /// Uncurried `mver`. Takes a key path and update function all at once.
    ///
    /// - Parameters:
    ///   - keyPath: A reference-writable key path.
    ///   - update: An update function for a given value.
    /// - Returns: A reference-mutable setter function.
    func mver<Root, Value>(
      _ keyPath: ReferenceWritableKeyPath<Root, Value>,
      _ update: @escaping (inout Value) -> Void
      )
      -> (Root) -> Void {

        return mprop(keyPath)(update)
    }

    /// Produces a value-mutable setter function for a given key path and new value.
    ///
    /// - Parameters:
    ///   - keyPath: A writable key path.
    ///   - value: A new value.
    /// - Returns: A value-mutable setter function.
    func mut<Root, Value>(
      _ keyPath: WritableKeyPath<Root, Value>,
      _ value: Value
      )
      -> (inout Root) -> Void {

        return mver(keyPath) { $0 = value }
    }

    /// Produces a reference-mutable setter function for a given key path and new value.
    ///
    /// - Parameters:
    ///   - keyPath: A reference-writable key path.
    ///   - value: A new value.
    /// - Returns: A reference-mutable setter function.
    func mut<Root, Value>(
      _ keyPath: ReferenceWritableKeyPath<Root, Value>,
      _ value: Value
      )
      -> (Root) -> Void {

        return mver(keyPath) { $0 = value }
    }
    
    func commaFormattedString(locale: String?, groupingSeparator: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = groupingSeparator
        
        if let locale = locale {
            numberFormatter.locale = Locale(identifier: locale)
        }
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    var kilobytes: Double {
        return Double(self) / 1024
    }
    
    var megabytes: Double {
        return kilobytes / 1024
    }
    
    var gigabytes: Double {
        return megabytes / 1024
    }
    
    var milisecondToSecond: Float {
        Float(self) / 1000
    }
    
    func getReadableUnit() -> String {
        switch self {
        case 0..<1024:
            return "\(self) bytes"
        case 1024..<(1024 * 1024):
            return "\(String(format: "%.2f", kilobytes)) kb"
        case 1024..<(1024 * 1024 * 1024):
            return "\(String(format: "%.2f", megabytes)) mb"
        case (1024 * 1024 * 1024)...Int(Int64.max):
            return "\(String(format: "%.2f", gigabytes)) gb"
        default:
            return "\(self) bytes"
        }
    }
}

