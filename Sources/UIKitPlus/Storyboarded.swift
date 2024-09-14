//
//  Storyboarded.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//


import UIKit

@MainActor public protocol Storyboarded {
    /// Name of the storyboard file.
    static var storyboardName: String { get }

    /// Identifier of the view controller in the associated storyboard or `nil`.
    /// In the latter case, the resultant identifier will be the last component of the full class name.
    /// ie. `com.example.SOMEClassName` will become `SOMEClassName`.
    static var storyboardIdentifier: String? { get }

    /// Ask the view controller to initialize itself from it's associated storyboard.
    /// You can either provide a bundle from which the view controller should load it's storyboard
    /// or left as `nil` so that it can try to resolve the bundle.
    /// In the latter case, the resultant bundle will be the one where the Callee View Controller type
    /// resides in.
    ///
    /// - parameters:
    ///     - bundle: Specific bundle or `nil` if you prefer to let the class resolve on it's own.
    ///
    /// - returns: A view controller initialized from it's associated storyboard.
    ///
    static func instantiate(from bundle: Bundle?) -> Self
}

extension Storyboarded where Self: UIViewController {
    /// Identifier of the view controller in the associated storyboard or `nil`.
    /// In the latter case, the resultant identifier will be the last component of the full class name.
    /// ie. `com.example.SOMEClassName` will become `SOMEClassName`.
    public static var storyboardIdentifier: String? { nil }

    // swiftlint:disable force_cast
    /// Ask the view controller to initialize itself from it's associated storyboard.
    /// You can either provide a bundle from which the view controller should load it's storyboard
    /// or left as `nil` so that it can try to resolve the bundle.
    /// In the latter case, the resultant bundle will be the one where the Callee View Controller type
    /// resides in.
    ///
    /// - parameters:
    ///     - bundle: Specific bundle or `nil` if you prefer to let the class resolve on it's own.
    ///
    /// - returns: A view controller initialized from it's associated storyboard.
    ///
    public static func instantiate(from bundle: Bundle? = nil) -> Self {
        // If the bundle is not provided, provide a supplement bundle.
        // Supplement bundle is the bundle where the Callee class resides in.
        let givenOrAutoResolvedBundle = bundle ?? Bundle(for: Self.classForCoder())

        // Try to get the storyboard with associated name from given bundle
        let storyboard = UIStoryboard(
            name: storyboardName, bundle: givenOrAutoResolvedBundle
        )

        // If the storyboard identifier is not provided, the resolved identifier
        // will be the last component of the class name
        // ie. com.example.SOMEClassName will be SOMEClassName
        let givenOrAutoResolvedStoryboardIdentifier = storyboardIdentifier ?? Self.className

        // From the obtaied storyboard, load the view controller with associated id.
        return storyboard.instantiateViewController(withIdentifier: givenOrAutoResolvedStoryboardIdentifier) as! Self
    }
}
