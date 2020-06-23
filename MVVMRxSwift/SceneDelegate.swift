//
//  SceneDelegate.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    var isRunningTests: Bool {
           return environmentValue(forKey: UITestingKey.isRunningTests) != nil
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        if isRunningTests {
            initializeMockServices()
        } 
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }
}

//// MARK: - Private Methods
extension SceneDelegate {
    
    private func initializeMockServices() {
        //ManagerInjector.newService = MockNewsService()
    }

    private func environmentValue(forKey key: TestingKeyIdentifiable) -> String? {
        return ProcessInfo.processInfo.environment[key.value]
    }
}
