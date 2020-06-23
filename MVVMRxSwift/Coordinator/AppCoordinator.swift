//
//  AppCoordinator.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
}


final class AppCoordinator: Coordinator {

    var window: UIWindow?
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let viewController: ViewController = UIStoryboard(storyboard: .main).instatiateViewController()
        viewController.viewModel = NewsListViewModel()
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
