//
//  AppCoordinator.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol Coordinator: class {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}


final class AppCoordinator: Coordinator {

    var window: UIWindow
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start(){
        let newsListCoordinator = NewsListCoordinator(window: window)
        return coordinate(to: newsListCoordinator)
    }
}
