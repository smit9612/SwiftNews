//
//  Restaurant.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

struct Restaurant: ServiceCodable {
    
    var name: String
    var cuisine: Cuisine
}

enum Cuisine: String, ServiceCodable {
    
    case european
    case indian
    case english
    case mexican
    case french
}
