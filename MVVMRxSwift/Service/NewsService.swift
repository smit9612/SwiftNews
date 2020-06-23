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
    
    func fetchNews() -> Observable<[Child]> {
                return Observable.create { observer -> Disposable in
                    // If URL
                    let task = URLSession.shared.dataTask(with: URL(string: "https://www.reddit.com/r/swift/.json")!) { data, _, _ in
                        guard let data = data else {
                            observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                            return
                        }
    
                        guard let feed: Feed = Feed.from(data: data), let news: [Child] = feed.data?.children else {
                            observer.onError(NSError(domain: "Error", code: -1, userInfo: nil))
                            return
                        }
                        observer.onNext(news)
                       
                    }
        
                    task.resume()
                    return Disposables.create {
                        task.cancel()
                    }
                }
            
    }
}
