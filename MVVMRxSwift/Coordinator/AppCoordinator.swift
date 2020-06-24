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

final class AppCoordinator: BaseCoordinator<Void> {

    var window: UIWindow
    var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let newsListCoordinator = NewsListCoordinator(window: window)
        return coordinate(to: newsListCoordinator)
    }
}
