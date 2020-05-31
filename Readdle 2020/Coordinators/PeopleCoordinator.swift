//
//  PersonCoordinator.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PeopleCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let viewController = PeopleViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Shows detail info about given Person.
    func showDetailedInfoAbout(person: Person) {
        let viewController = DetailedInfoViewController()
        viewController.coordinator = self
        viewController.person = person
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
