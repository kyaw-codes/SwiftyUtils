//
//  URL.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 02/07/2024.
//

import UIKit
import Foundation
import MobileCoreServices

public enum FileType {
    case image
    case gif
    case pdf

    public init?(from url: URL) {
        let fileExtension = url.pathExtension as CFString
        let fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, nil)
        guard let uti = fileUTI?.takeRetainedValue() else {
            return nil
        }

        if UTTypeConformsTo(uti, kUTTypeGIF) {
            self = .gif
        } else if UTTypeConformsTo(uti, kUTTypeImage) {
            self = .image
        } else if UTTypeConformsTo(uti, kUTTypePDF) {
            self = .pdf
        } else {
            return nil
        }
    }
}

@available(iOS, deprecated: 16.0, message: "Use the built-in API instead")
public extension URL {
  static var documentsDirectory: Self {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
}

public extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }

    var queryParameters: QueryParameters {
        return QueryParameters(url: self)
    }

    var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil }

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {
            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy: "=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }

    mutating func excludeFromBackup() throws {
        var resource = URLResourceValues()
        resource.isExcludedFromBackup = true
        try setResourceValues(resource)
    }

    func toMBFileSize(descimalCount: Int) -> Double {
        if let resources = try? self.resourceValues(forKeys: [.fileSizeKey]) {
            return (Double(resources.fileSize ?? 0) / 1000000).rounded(descimalCount: descimalCount)
        } else {
            return 0
        }
    }

    func getFileSize() -> Double {
        let data = try? Data(contentsOf: self)
        return data?.mBSize.toDouble.orElse(0) ?? 0
    }

    func isGIF() -> Bool {
        return self.absoluteString.hasSuffix("GIF") || self.absoluteString.hasSuffix("gif")
    }

    func toJPEGDataIfIsImage(compressionQuality: CGFloat = 1) -> Data? {
        guard let type = FileType(from: self) else { return nil }
        switch type {
        case .image:
            let data = try? Data(contentsOf: self)
            return data.flatMap(UIImage.init).flatMap {
                $0.jpegData(compressionQuality: compressionQuality)
            }
        case .gif:
            return try? Data(contentsOf: self)
        case .pdf:
            return try? Data(contentsOf: self)
        }
    }
}

public class QueryParameters {
    public let queryItems: [URLQueryItem]

    public init(url: URL?) {
        queryItems = URLComponents(string: url?.absoluteString ?? "")?.queryItems ?? []
        print(queryItems)
    }

    public subscript(name: String) -> String? {
        return queryItems.first { $0.name == name }?.value
    }
}

public extension URL {
    /// Returns a URL constructed by appending the given query string parameter to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.appendingQueryItem("def", value: "456") // "https://example.com?abc=123&lmn=tuv&xyz=987&def=456"
    ///     url?.appendingQueryItem("xyz", value: "999") // "https://example.com?abc=123&lmn=tuv&xyz=999"
    ///
    /// - Parameters:
    ///   - name: The key of the query string parameter.
    ///   - value: The value to replace the query string parameter, nil will remove item.
    /// - Returns: The URL with the appended query string.
    func appendingQueryItem(_ name: String, value: Any?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return self
        }

        urlComponents.queryItems = urlComponents.queryItems?
            .filter { $0.name.caseInsensitiveCompare(name) != .orderedSame } ?? []

        // Skip if nil value
        if let value = value {
            urlComponents.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))
        }

        return urlComponents.url ?? self
    }

    /// Returns a URL constructed by appending the given query string parameters to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.appendingQueryItems([
    ///         "def": "456",
    ///         "jkl": "777",
    ///         "abc": "333",
    ///         "lmn": nil
    ///     ]) // "https://example.com?xyz=987&def=456&abc=333&jkl=777"
    ///
    /// - Parameter contentsOf: A dictionary of query string parameters to modify.
    /// - Returns: The URL with the appended query string.
    func appendingQueryItems(_ contentsOf: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !contentsOf.isEmpty else {
            return self
        }

        let keys = contentsOf.keys.map { $0.lowercased() }

        urlComponents.queryItems = urlComponents.queryItems?
            .filter { !keys.contains($0.name.lowercased()) } ?? []

        urlComponents.queryItems?.append(contentsOf: contentsOf.compactMap {
            guard let value = $0.value else { return nil } // Skip if nil
            return URLQueryItem(name: $0.key, value: "\(value)")
        })

        return urlComponents.url ?? self
    }

    /// Returns a URL constructed by removing the given query string parameter to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.removeQueryItem("xyz") // "https://example.com?abc=123&lmn=tuv"
    ///
    /// - Parameter name: The key of the query string parameter.
    /// - Returns: The URL with the mutated query string.
    func removeQueryItem(_ name: String) -> URL {
        appendingQueryItem(name, value: nil)
    }
}

public extension URL {
    /// Query a URL from a parameter name.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.queryItem("aBc") // "123"
    ///     url?.queryItem("lmn") // "tuv"
    ///     url?.queryItem("yyy") // nil
    ///
    /// - Parameter name: The key of the query string parameter.
    /// - Returns: The value of the query string parameter.
    func queryItem(_ name: String) -> String? {
        // https://stackoverflow.com/q/41421686
        URLComponents(string: absoluteString)?
            .queryItems?
            .first { $0.name.caseInsensitiveCompare(name) == .orderedSame }?
            .value
    }
}
