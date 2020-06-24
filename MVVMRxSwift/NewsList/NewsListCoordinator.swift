//
//  NewsListCoordinator.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import RxSwift

final class NewsListCoordinator: BaseCoordinator<Void> {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController: ViewController = UIStoryboard(storyboard: .main).instatiateViewController()
        let viewModel:NewsListViewModel = NewsListViewModel()
        viewController.viewModel = viewModel
        // viewModel some observer to  which will call detailsview with child
//        viewModel.showNews.debug().subscribe(onNext: { [weak self] in self?.showDetailsView(with: $0)
//              }).disposed(by: disposeBag)
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return Observable.never()
    }
    
}


