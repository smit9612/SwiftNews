//
//  NewsDetailsCoordinator.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit

final class NewsDetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
    private func showDetailView(with post: Post) {
        let viewController = PostDetailViewController.instance()
        viewController.viewModel = PostDetailViewModel(post: post)
        navigationController.showDetailViewController(viewController, sender: nil)
    }
}
