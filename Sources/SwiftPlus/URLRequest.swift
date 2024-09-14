//
//  URLRequest.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

public extension URLRequest {
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let url {
            dict["url"] = url.absoluteString
            if let parameters = url.queryDictionary {
                dict["parameters"] = parameters
            }
        }
        dict["method"] = httpMethod
        if let allHTTPHeaderFields, allHTTPHeaderFields.isNotEmpty {
            dict["headers"] = allHTTPHeaderFields
        }
        if let httpBody = httpBody {
            dict["body"] = httpBody.toDictionary()
        }
        return dict
    }
}
