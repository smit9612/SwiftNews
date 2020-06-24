//
//  NewsDetailsViewModel.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxNuke

struct NewsDetailsViewModel {
    let title: Driver<String>
    let displaytext: Driver<String>
    //let image: Driver<String>
    let newsViewModel: NewsViewModel
    
    init(newsViewModel: NewsViewModel) {
        self.newsViewModel = newsViewModel
        self.title = Observable.just(newsViewModel.title).asDriver(onErrorJustReturn: "Error")
        self.displaytext = Observable.just(newsViewModel.displayText).asDriver(onErrorJustReturn: "Error")
        
//        self.body = Observable.just(post.body).asDriver(onErrorJustReturn: "Error")
    }
    
    
}
