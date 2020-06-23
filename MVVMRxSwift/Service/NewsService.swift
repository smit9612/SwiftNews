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
