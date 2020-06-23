//
//  ServiceServiceCodable.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

/// Provides convenient interfaces related to data encoding/decoding
protocol ServiceCodable: Codable {
    
    /// Converts data to a PlatformNetworkServiceCodable DataModel object
    ///
    /// - Parameter data: A JSON deServiceCodable data
    /// - Returns: An object conforming PlatformNetworkServiceCodable
    static func from<T>(data: Data) -> T? where T: ServiceCodable
    
    /// Converts data to an array of PlatformNetworkServiceCodable DataModel object
    ///
    /// - Parameter data: A JSON deServiceCodable data
    /// - Returns: An array of an object conforming PlatformNetworkServiceCodable
    static func arrayFrom<T>(data: Data) -> [T]? where T: ServiceCodable
    
    /// A Data value, which is encoded from a PlatformNetworkServiceCodable DataModel
    var data: Data? { get }
}

extension ServiceCodable {

    public static func from<T>(data: Data) -> T? where T: ServiceCodable {
        guard let decodedObj = try? JSONDecoder().decode(T.self, from: data) else {
            print("Unable to decode \(T.self).")
            return nil
        }
        
        return decodedObj
    }

    public static func arrayFrom<T>(data: Data) -> [T]? where T: ServiceCodable {
        guard let decodedObj = try? JSONDecoder().decode([T].self, from: data) else {
            print("Unable to decode array \(T.self).")
            return nil
        }
        
        return decodedObj
    }

    /// A Dictionary value having a key as String type, which is converted from an encoded data type of a PlatformNetworkServiceCodable model
    public var dictionary: [String: Any] {
        guard let data = data else { return [:] }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let dic = jsonObject as? [String: Any] else { return [:] }
        return dic
    }

    public var data: Data? {
        guard let encodedData = try? JSONEncoder().encode(self) else {
            print("Unable to encode \(self).")
            return nil
        }
        
        return encodedData
    }
}
