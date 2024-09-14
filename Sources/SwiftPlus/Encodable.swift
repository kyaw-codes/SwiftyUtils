//
//  Encodable.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

// MARK: Need documentation and UTs
public extension Encodable {
    func toDict(_ encoder: JSONEncoder = .init()) -> [String: Any] {
        do {
            let data = try encoder.encode(self)
            let dic =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
            
        } catch {
            return [:]
        }
    }
    
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }

    func toJsonString(encoder: JSONEncoder = .init()) -> String? {
        do {
            let data = try encoder.encode(self)
            let string = String(data: data, encoding: .utf8)
            return string
        } catch {
            return ""
        }
    }
}
