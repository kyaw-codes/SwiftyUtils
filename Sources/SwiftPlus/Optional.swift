//
//  Optional.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

// MARK: Need documentation and UTs
public extension Optional {
    static func pure(_ x: Wrapped) -> Optional {
        .some(x)
    }
    
    static func zip<A, B>(_ x: A?, _ y: B?) -> (A, B)? {
        switch (x, y) {
        case (.some(let x), .some(let y)):
            return .some((x, y))
        default:
            return nil
            
        }
    }

    func apply<B>(_ f: Optional<(Wrapped) -> B>) -> Optional<B> {
        switch (f, self) {
        case let (.some(fx), _):
            return self.map(fx)
        default:
            return .none
        }
    }
    
    func orElse(_ x: Wrapped) -> Wrapped {
        switch self {
        case .none: return x
        case .some(let v): return v
        }
    }
    
    func then(_ f: (Wrapped) -> Void) {
        switch self {
        case .some(let value):
            f(value)
        case .none:
            return
        }
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .none: return ""
        case .some(let v): return v
        }
    }
    
    func ifNilOrEmpty(_ value: String) -> String {
        self.orEmpty.isEmpty ? value : self.orEmpty
    }

}

public extension Optional where Wrapped == Double {
    
    var orEmpty: Double {
        switch self {
        case .none: return 0
        case .some(let v): return v
        }
    }
}

public extension Optional where Wrapped == Bool {
    
    var orFalse: Bool {
        switch self {
        case .none: return false
        case .some(let v): return v
        }
    }
    
    var orTrue: Bool {
        switch self {
        case .none: return true
        case .some(let v): return v
        }
    }
}

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return self != nil
    }
}
