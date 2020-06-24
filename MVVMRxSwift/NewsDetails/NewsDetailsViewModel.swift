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
import Nuke

final class NewsDetailsViewModel: ManagerInjected {
    
    let title: Observable<String>
    let displaytext: Observable<String>
    let newsViewModel: NewsViewModel
    
    init(newsViewModel: NewsViewModel) {
        self.newsViewModel = newsViewModel
        self.title = Observable.just(newsViewModel.title)
        self.displaytext = Observable.just(newsViewModel.displayText)
    }
    
    func loadImage() -> Observable<UIImage?>{
        if let url = newsViewModel.imageURL {
            return imageLoaderService.loadImage(url: url)
        } else {
            return Observable.just(UIImage())
        }
    }

}
