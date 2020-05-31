//
//  PeopleCollectionViewDataSource.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PeopleCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var alertHandler: AlertHandler?
    var currentLayout: PeopleLayout
    
    // MARK: - Initialization
    
    init(currentLayout: PeopleLayout) {
        self.currentLayout = currentLayout
    }
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PersonsWarehouse.shared.totalNumberOfPersons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let person = PersonsWarehouse.shared.getPerson(at: indexPath.row) else {
            fatalError("Cannot get a Person for the indexPath: \(indexPath), but should be able to.")
        }
        
        switch currentLayout {
        case .list:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonListCollectionViewCell.reuseIdentifier, for: indexPath) as? PersonListCollectionViewCell else {
                fatalError("The dequeued cell is not an instance of PersonListCollectionViewCell.")
            }
            cell.alertHandler = alertHandler
            let viewModel = PersonListCollectionViewCellViewModel(person: person)
            cell.configure(with: viewModel)
            return cell
        case .grid:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonGridCollectionViewCell.reuseIdentifier, for: indexPath) as? PersonGridCollectionViewCell else {
                fatalError("The dequeued cell is not an instance of PersonGridCollectionViewCell.")
            }
            cell.alertHandler = alertHandler
            let viewModel = PersonGridCollectionViewCellViewModel(person: person)
            cell.configure(with: viewModel)
            return cell
        }
    }
    
}
