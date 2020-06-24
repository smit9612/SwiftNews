//
//  NewsListCoordinator.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import RxSwift

protocol NewsListCoordinatorProtocol: class {
    
    func showDetailsView(with news: NewsViewModel)
}


final class NewsListCoordinator: Coordinator {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController: ViewController = UIStoryboard(storyboard: .main).instatiateViewController()
        let viewModel:NewsListViewModel = NewsListViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension NewsListCoordinator: NewsListCoordinatorProtocol {
    
    func showDetailsView(with news: NewsViewModel) {
        let detailsViewController: NewsDetailsViewController = UIStoryboard(storyboard: .main).instatiateViewController()
        
        // set view model
        detailsViewController.viewModel = NewsDetailsViewModel(newsViewModel: news)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}


