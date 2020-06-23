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
    
    var imageLoader: ImageLoaderProtocol {
        return ManagerInjector.imageLoader
    }
    
    var urlSession: URLSession {
        return ManagerInjector.urlSession
    }
    
}

struct ManagerInjector {
    

    static var newService: NewsServiceProtocol = NewsService()
    
    static var imageLoader: ImageLoaderProtocol = ImageLoader()
    
    static var urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    static func createURLSession(configuration: URLSessionConfiguration = URLSessionConfiguration.default, delegate: URLSessionDelegate? = nil) -> URLSession {
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
