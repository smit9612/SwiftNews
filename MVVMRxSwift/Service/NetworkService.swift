//
//  NetworkService.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift
import UIKit



final class NetworkService: ManagerInjected {
    
    var logger = NetworkLogger(logFileName: "Log.txt")
    static let shared: NetworkService = NetworkService()
    // TODO last modified or ETag to check if image is update
    var imageCache = ImageCache()
    
    init() {
        ManagerInjector.urlSession = ManagerInjector.createURLSession(delegate: nil)
    }
    
    func setURLSession(_ urlSession: URLSession? = nil) {
        ManagerInjector.urlSession = urlSession ?? ManagerInjector.createURLSession()
    }
    
    func requestImage(url: URL, cache: ImageCaching? = NetworkService.shared.imageCache) -> Observable<UIImage?> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return Observable.create { observer -> Disposable in
            if let image = cache?.imageFromCachedWithUrl(url: url) {
                observer.onNext(image)
                observer.onCompleted()
                return Disposables.create {}
            } else {
                let task = ManagerInjector.urlSession.dataTask(with: urlRequest) { data, _, _ in
                    guard let unwrappedData = data else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return
                    }
                    let image = UIImage(data: unwrappedData)
                    cache?.saveImagetoCache(image: image, url: url)
                    observer.onNext(image)
                    observer.onCompleted()
                }
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }
        }
    }
    
    func execute<T: ServiceCodable>(url: URL) -> Observable<[T]> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return Observable.create { [unowned self] observer -> Disposable in
            let task = ManagerInjector.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
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
