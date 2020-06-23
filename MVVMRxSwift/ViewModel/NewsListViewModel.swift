//
//  RestaurantViewModel.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import RxSwift

struct NewsListViewModel: ManagerInjected {
    
    let title = "Swift News"

    func fetchNewListViewModel() -> Observable<[NewsViewModel]> {
        newsService.fetchNews().map { $0.map {
                return NewsViewModel(child: $0)
            }
        }
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



