//
//  StoryboardIdentifiable.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit



protocol UIStoryboardInitiatable {
    /// A string type of enum conforming RawRepresentable. Each case represents a name of the storyboard.
        ///
        /// - Example:
        ///
        /// ````swift
        /// // Storyboard+Extensions.swift
        /// extension Storyboard {
        ///
        ///     enum Storyboard: String {
        ///         case main = "Main" // Main.storyboard
        ///     }
        /// }
        /// ````
        associatedtype Storyboard: RawRepresentable
}

extension UIStoryboardInitiatable where Self: UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}

protocol UIStoryboardIdentifiable {

    static var storyboardIdentifier: String { get }
}

extension UIViewController: UIStoryboardIdentifiable {}

extension UIStoryboardIdentifiable where Self: UIViewController {

    static var storyboardIdentifier : String {
        return String(describing: self)
    }
}
