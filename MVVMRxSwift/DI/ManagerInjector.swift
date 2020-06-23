//
//  ManagerInjector.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

protocol ManagerInjected {}

extension ManagerInjected {
    
    var newsService: NewsServiceProtocol {
        return ManagerInjector.newService
    }
    
}

struct ManagerInjector {
    
    static var newService: NewsServiceProtocol = MockNewsService()
}
