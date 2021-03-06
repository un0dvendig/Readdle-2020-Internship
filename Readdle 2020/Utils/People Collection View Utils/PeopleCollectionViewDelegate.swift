//
//  PeopleCollectionViewDelegate.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PeopleCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    weak var coordinatorReference: PeopleCoordinator?
    var currentLayout: PeopleLayout
    
    // MARK: - Initialization
    
    init(currentLayout: PeopleLayout) {
        self.currentLayout = currentLayout
    }
    
    // MARK: - UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let person = PersonsWarehouse.shared.getPerson(at: indexPath.row) else {
            return
        }
        coordinatorReference?.showDetailedInfoAbout(person: person)
    }
    
}
