//
//  NewsService.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsServiceProtocol {
    
    func fetchNews() -> Observable<[Feed]>
}

final class NewsService: NewsServiceProtocol {
    
    private let baseURLString = "https://www.reddit.com"
    
    func fetchNews() -> Observable<[Feed]> {
        return NetworkService.shared.execute(url: URL(string: baseURLString + "/r/swift/.json")!)
    }
}


final class NetworkService: ManagerInjected {
    
    var logger = NetworkLogger(logFileName: "Log.txt")
    static let shared: NetworkService = NetworkService()
    
    init() {
        ManagerInjector.urlSession = ManagerInjector.createURLSession(delegate: nil)
    }

    func setURLSession(_ urlSession: URLSession? = nil) {
        ManagerInjector.urlSession = urlSession ?? ManagerInjector.createURLSession()
    }
    
    func execute <T:ServiceCodable>(url:URL) -> Observable<[T]> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return Observable.create { observer -> Disposable in
            let task = ManagerInjector.urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                self?.logger.log(response: response as? HTTPURLResponse, data: data, error: error)
                
                guard let unwrappedData = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                if let contentModel: T = T.from(data: unwrappedData) {
                    print(contentModel)
                    observer.onNext([contentModel])
                } else if let contentModels: [T] = T.arrayFrom(data: unwrappedData) {
                    observer.onNext(contentModels)
                }
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
