//
//  Data.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 01/07/2024.
//

import Foundation

public extension Data {
  var string: String? {
    String(data: self, encoding: .utf8)
  }
  
  static func generateRandom() -> Data {
    var keyData = Data(count: 64)
    _ = keyData.withUnsafeMutableBytes {
      SecRandomCopyBytes(kSecRandomDefault, 64, $0.baseAddress!)
    }
    return keyData
  }
  
  var getMB: String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(count))
  }
  
  var getMBSize: String {
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
  
  var mimeType: String {
    var c: UInt8 = 0
    copyBytes(to: &c, count: 1)
    return Data.mimeTypeSignatures[c] ?? ""
  }
  
  var fileExt: String {
    self.mimeType.split(separator: "/").last.map { String($0) } ?? ""
  }
  
  func decode<T: Decodable>(
    _ type: T.Type = T.self,
    decoder: JSONDecoder = .init()
  ) -> T? {
    do {
      return try decoder.decode(T.self, from: self)
    }
    catch {
      print("🛑", error)
      return nil
    }
  }
}

public func decodeJSON<T: Decodable>(name: String, from bundle: Bundle = .main) -> T? {
  Bundle.main.url(forResource: name, withExtension: "json")
    .flatMap { try? Data(contentsOf: $0) }
    .flatMap { $0.decode(T.self) }
}
