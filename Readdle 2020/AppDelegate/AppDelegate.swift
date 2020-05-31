//
//  AppDelegate.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var coordinator: PeopleCoordinator?
    var window: UIWindow?

    // MARK: - UIApplicationDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupCoordinator()
        
        return true
    }
    
    // MARK: - Private methods
    
    private func setupCoordinator() {
        let navigationController = UINavigationController()
        coordinator = PeopleCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    

}

