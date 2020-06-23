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

    private let child: Child

    init(child: Child) {
        self.child = child
    }

    var displayText: String {
        return child.data?.selftext ?? ""
    }
}
