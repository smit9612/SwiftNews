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
    
    func fetchNews() -> Observable<[Child]>
}

final class NewsService: NewsServiceProtocol {
    
    private let networkService = NetworkService()
    private let baseURLString = "https://www.reddit.com"
    
    func fetchNews() -> Observable<[Child]> {
        return networkService.execute(url: URL(string: baseURLString + "/r/swift/.json")!)
    }
}


final class NetworkService {
    
    var logger = NetworkLogger(logFileName: "Log.txt")
    
    
    func execute <T:ServiceCodable>(url:URL) -> Observable<[T]> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                self?.logger.log(response: response as? HTTPURLResponse, data: data, error: error)
                
                guard let unwrappedData = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                if let contentModel: T = T.from(data: unwrappedData) {
                    observer.onNext([contentModel])
                } else if let contentModels: [T] = T.arrayFrom(data: unwrappedData) {
                    observer.onNext(contentModels)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
