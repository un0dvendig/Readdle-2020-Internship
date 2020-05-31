//
//  PeopleViewModel.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

struct PeopleViewModel {
    
    // MARK: - Properties
    
    weak var alertHandlerReference: AlertHandler?
    
    weak var coordinatorReference: PeopleCoordinator? {
        didSet {
            if let collectionViewDelegate = self.collectionViewDelegate {
                collectionViewDelegate.coordinatorReference = coordinatorReference
            }
        }
    }
    
    var currentLayout: PeopleLayout {
        didSet {
            if let collectionViewDataSource = self.collectionViewDataSource {
                collectionViewDataSource.currentLayout = self.currentLayout
            }
            
            if let collectionViewDelegate = self.collectionViewDelegate {
                collectionViewDelegate.currentLayout = self.currentLayout
            }
        }
    }
    
    var collectionViewDataSource: PeopleCollectionViewDataSource?
    var collectionViewDelegate: PeopleCollectionViewDelegate?
    
    // MARK: - Initialization
    
    init() {
        self.currentLayout = .list
        
        let dataSource = PeopleCollectionViewDataSource(currentLayout: currentLayout)
        dataSource.alertHandler = alertHandlerReference
        self.collectionViewDataSource = dataSource
        
        let delegate = PeopleCollectionViewDelegate(currentLayout: currentLayout)
        self.collectionViewDelegate = delegate
    }
    
}
