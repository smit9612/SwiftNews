//
//  NewsService.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift

final class MockNewsService: NewsServiceProtocol {
    
    func fetchNews() -> Observable<[Child]> {
                return Observable.create { observer -> Disposable in
                    // If Usin Mock Data
                    guard let path = Bundle.main.path(forResource: "mockswiftnews", ofType: "json") else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return Disposables.create()
                    }
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        guard let feed: Feed = Feed.from(data: data), let news: [Child] = feed.data?.children else {
                            observer.onError(NSError(domain: "Error", code: -1, userInfo: nil))
                            return Disposables.create()
                        }
                        observer.onNext(news)
                    } catch {
                        observer.onError(error)
                    }
                    return Disposables.create {}
                }
    }
}
