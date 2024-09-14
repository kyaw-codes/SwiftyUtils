//
//  String.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

// MARK: Need documentation and UTs
public extension String {
    
    var containsSpecialChar: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    static let empty = ""
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
        
    var removedDot: String {
        return self.replacingOccurrences(of: ".", with: "")
    }
    
    var isPhoneNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "+0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var toDouble: Double? {
        return Double(self)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toIntFlag() -> Int? {
        switch self {
        case "True", "true", "yes", "1":
            return 1
        case "False", "false", "no", "0":
            return 0
        default:
            return nil
        }
    }
    
    func decode<T: Codable>() -> [T]? {
        let decoder = JSONDecoder()
        guard let data = self.data(using: .utf8) else { return nil }
        return try? decoder.decode([T].self, from: data)
    }
    
    func decodeSingle<T: Codable>() -> T? {
        let decoder = JSONDecoder()
        guard let data = self.data(using: .utf8) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func repeated(_ count: Int) -> [String] {
        var res: [String] = []
        for _ in 0..<count {
            res.append(self)
        }
        return res
    }
    
    func contains(_ value: [String]) -> Bool {
        var contains: Bool = false
        for value in value {
            if self.contains(value) {
                contains = true
                break
            }
        }
        return contains
    }

    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func removeSuffix(_ string: String) -> String {
        if self.hasSuffix(string) {
            return String(self.dropLast(string.count))
        }
        return self
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: self) {
            return true
        }
        return false
    }
    
    func isImageURL() -> Bool {
        let imageFormats = ["jpg", "png", "gif", "jpeg"]
        
        if URL(string: self) != nil {
            let extensi = (self as NSString).pathExtension
            return imageFormats.contains(extensi)
        }
        return false
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    /// Adds a separator at every N characters
    /// - Parameters:
    ///   - separator: the String value to be inserted, to separate the groups. Default is " " - one space.
    ///   - stride: the number of characters in the group, before a separator is inserted. Default is 4.
    /// - Returns: Returns a String which includes a `separator` String at every `stride` number of characters.
    func separated(by separator: String = " ", stride: Int = 4) -> String {
        return enumerated().map { $0.isMultiple(of: stride) && ($0 != 0) ? "\(separator)\($1)" : String($1) }.joined()
    }
    
    /**
     Getting Last 4
     */
    func last(_ k: Int) -> String {
        let maxCount = self.count
        if maxCount >= k {
            return self.substring(from: maxCount - k, to: maxCount)
        } else {
            return ""
        }
    }
    
    func toDate(dateFormat: String, withoutTimeZone: Bool = false) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        if withoutTimeZone { formatter.timeZone = TimeZone(secondsFromGMT: 0) }
        return formatter.date(from: self)
    }
        
    func add(character: String, byOffset offset: Int) -> String {
        var newString = ""
        
        for (index, char) in self.enumerated() {
            
            if index % offset == 0 && index != 0 {
                newString += "\(character)"
            }
            newString += "\(char)"
        }
        return newString
    }
    
    func appendedFirst(_ value: String) -> String {
        value + self
    }
    
    func removed(_ value: String) -> String {
        replacingOccurrences(of: value, with: "")
    }
    
    var isNumberWithDecimal: Bool {  return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil }
    
    var isNumber: Bool { return Int(self) != nil }
    
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
