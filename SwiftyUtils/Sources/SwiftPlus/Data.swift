//
//  Data.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 01/07/2024.
//

import Foundation

public extension Data {
  /// Converts the `Data` instance to a `String` using UTF-8 encoding.
  var string: String? {
    String(data: self, encoding: .utf8)
  }
  
  /// Generates a Data object containing 64 random bytes.
  ///
  /// This is useful for cryptographic purposes, generating random keys, initialization vectors, or other security-related data.
  /// - Parameter count: The number of random bytes to generate. Default value is 64.
  /// - Returns: A Data object containing the specified number of random bytes.
  static func generateRandom(_ count: Int = 64) -> Data {
    var keyData = Data(count: count)
    _ = keyData.withUnsafeMutableBytes {
      SecRandomCopyBytes(kSecRandomDefault, 64, $0.baseAddress!)
    }
    return keyData
  }
  
  /// Formats the byte count of a `Data` object as a string representing the size in megabytes (MB)
  var mB: String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(count))
  }
  
  /// Formats the byte count of a `Data` object as a string representing the size in megabytes (MB) without including the unit
  var mBSize: String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB]
    formatter.countStyle = .file
    formatter.includesUnit = false
    return formatter.string(fromByteCount: Int64(count))
  }
  
  private static let mimeTypeSignatures: [UInt8 : String] = [
    0xFF : "image/jpeg",
    0x89 : "image/png",
    0x47 : "image/gif",
    0x49 : "image/tiff",
    0x4D : "image/tiff",
    0x25 : "application/pdf",
    0xD0 : "application/vnd",
    0x46 : "text/plain",
  ]
  
  /// Determines the MIME type of the Data object based on its first byte.
  ///
  /// It uses a predefined dictionary of MIME type signatures to map the byte to the corresponding MIME type.
  var mimeType: String {
    var c: UInt8 = 0
    copyBytes(to: &c, count: 1)
    return Data.mimeTypeSignatures[c] ?? ""
  }
  
  /// Extracts the file extension from the MIME type of the `Data` object.
  ///
  /// It splits the MIME type string at the "/" character and returns the last component, which typically represents the file extension.
  var fileExtension: String {
    self.mimeType.split(separator: "/").last.map { String($0) } ?? ""
  }
  
  /**
   Decode a `Data` object into an instance of a specified type that conforms to the `Decodable` protocol.
   - Parameters:
     - type: The type to decode the data into. It defaults to the inferred type.
     - decoder: The `JSONDecoder` instance to use for decoding. It defaults to a new `JSONDecoder`.
   - Returns: An optional value of the specified type `T?`. Returns the decoded object if successful, otherwise returns `nil`.
   
   This function can be used whenever you need to decode JSON data into a Swift type that conforms to the Decodable protocol. It simplifies the process of decoding by handling errors and assertions internally.
   
   ```swift
   struct Person: Decodable {
       let firstName: String
       let lastName: String
   }

   let jsonData = """
   {
       "firstName": "John",
       "lastName": "Doe"
   }
   """.data(using: .utf8)!

   if let person = jsonData.decode(Person.self) {
       print("First Name: \(person.firstName), Last Name: \(person.lastName)")
   } else {
       print("Failed to decode JSON data.")
   }
   ```
   */
  func decode<T: Decodable>(
    _ type: T.Type = T.self,
    decoder: JSONDecoder = .init()
  ) -> T? {
    do {
      return try decoder.decode(T.self, from: self)
    }
    catch {
      assertionFailure(error.localizedDescription)
      return nil
    }
  }
}

/// Reads a JSON file from the specified bundle and decodes its contents into an instance of a specified type that conforms to the Decodable protocol.
/// - Parameters:
///   - name: The name of the JSON file (without the `.json` extension) to be decoded.
///   - bundle: The bundle containing the JSON file. Defaults to the main bundle.
/// - Returns: An optional value of the specified type `T?`. Returns the decoded object if successful, otherwise returns `nil`.
public func decodeJSON<T: Decodable>(name: String, from bundle: Bundle = .main) -> T? {
  Bundle.main.url(forResource: name, withExtension: "json")
    .flatMap { try? Data(contentsOf: $0) }
    .flatMap { $0.decode(T.self) }
}
