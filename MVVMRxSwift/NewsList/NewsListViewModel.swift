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
        let news = newsViewModels.map { $0.flatMap { $0 } }.map { $0.filter { !$0.title.isEmpty } }
        
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

    var title: String {
        return child.childData?.title ?? ""
    }
    // TODO Unit test for 
    var displayText: String {
        return child.childData?.selftext ?? ""
    }
    
    var thumbSize: CGSize {
        guard let height = child.childData?.thumbHeight, let width = child.childData?.thumbWidth else {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: width, height: height)
    }
    
    var sourceURL: URL? {
        guard let sourceURl = child.childData?.preview?.images?.first?.source?.url, let imageURL = URL(string:sourceURl) else {
            return nil
        }
        return imageURL
    }
    
    // TODO Unit  test for imageURL
    var imageURL: URL? {
        // here we can also check if thumb is valid URL check instead of return string.
        guard let thumbnail = child.childData?.thumbnail, !notallowedURL.contains(thumbnail), let imageURL = URL(string:thumbnail) else {
            return nil
        }
        return imageURL
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
