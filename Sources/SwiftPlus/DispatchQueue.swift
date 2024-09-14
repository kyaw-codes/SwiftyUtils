//
//  DispatchQueue.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import Foundation

public func delay(_ sec: Double, execute:@Sendable @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + sec), execute: execute)
}

public func onMainThread(execute:@Sendable @escaping () -> Void) {
    DispatchQueue.main.async(execute: execute)
}
