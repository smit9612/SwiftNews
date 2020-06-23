//
//  RestaurantViewModel.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct NewsListViewModel: ManagerInjected {

    let title = "Swift News"
    let db = DisposeBag()
    func fetchNewListViewModel() -> Observable<[NewsViewModel]> {
        let flatMappedFeeds = newsService.fetchNews()
            .map { feeds in feeds.compactMap { return FeedViewModel(feed: $0) } }
        let newsViewModels = flatMappedFeeds.map { $0.map { $0.news } }
        let news = newsViewModels.map { $0.flatMap { $0 } }
        return news
    }
}

struct FeedViewModel {

    let news: [NewsViewModel]

    init(feed: Feed?) {
        self.news = feed?.children?.map { NewsViewModel(child: $0) } ?? [NewsViewModel(child: Child())]
    }
}

struct NewsViewModel {

    var child: Child

    init(child: Child) {
        self.child = child
    }

    // TODO Unit test for 
    var displayText: String {
        return child.childData?.selftext ?? ""
    }
    
    // TODO Unit  test for imageURL
    var imageURL: String? {
        guard let thumbnail = child.childData?.thumbnail, thumbnail != "self" else {
            return nil
        }
        return thumbnail
    }
}

extension UIImageView: ManagerInjected {
    
    func loadImage(url: URL) {
        let _ = imageLoader.loadImage(url: url).map { [weak self] in
            self?.image = $0
        }
    }
}
