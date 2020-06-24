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

final class NewsListViewModel: ManagerInjected {

    let title = "Swift News"
    let db = DisposeBag()

    let didSelectNews = PublishSubject<NewsViewModel>()
    
    /// Call to open news details page.
    var selectedNews: AnyObserver<NewsViewModel> = PublishSubject<NewsViewModel>().asObserver()
    
    /// Emits an url of repository page to be shown.
    var showNews: Observable<NewsViewModel> = Observable.just(NewsViewModel(child: Child()))
   
    func fetchNewListViewModel() -> Observable<[NewsViewModel]> {
        
        let flatMappedFeeds = newsService.fetchNews()
            .map { feeds in feeds.compactMap { return FeedViewModel(feed: $0) } }
        let newsViewModels = flatMappedFeeds.map { $0.map { $0.news } }
        let news = newsViewModels.map { $0.flatMap { $0 } }
        
        selectedNews = didSelectNews.asObserver()
        showNews = didSelectNews.asObservable().map { $0 }
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
        // here we can also check if thumb is valid URL check instead of return string.
        guard let thumbnail = child.childData?.thumbnail, !notallowedURL.contains(thumbnail) else {
            return nil
        }
        return thumbnail
    }
    
    private var notallowedURL: [String] {
        return ["self", "default"]
    }
}

extension UIImageView: ManagerInjected {
    
    func loadImage(url: URL) {
        let _ = imageLoader.loadImage(url: url).map { [weak self] in
            self?.image = $0
        }
    }
}
