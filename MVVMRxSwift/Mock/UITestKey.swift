//
//  UITestKey.swift
//  MVVMRxSwiftTests
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

protocol TestingKeyIdentifiable {

    var value: String { get }
}

extension TestingKeyIdentifiable where Self: RawRepresentable, Self.RawValue == String {

    var value: String {
        return rawValue
    }
}

enum UITestingKey: String, TestingKeyIdentifiable {
    case isRunningTests = "UNITTEST"
}
