//
//  PeopleCollectionViewGridLayout.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

protocol CustomDelegate: class {
    func numberOfItemsInCollectionView() -> Int
}

extension CustomDelegate {
    func heightForContentInItem(at indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

class PeopleCollectionViewGridLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    
    weak var delegate: CustomDelegate?
    
    // MARK: - Private properties
    
    private let numberOfColumns = 3
    private let cellPadding: CGFloat = 6
    private let cellHeight: CGFloat = 150
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    // MARK: - UICollectionViewLayout properties
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - UICollectionViewLayout methods
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0..<numberOfColumns {
            if column == 0 {
                xOffset.append(0)
            }
            if column == 1 {
                xOffset.append(2 * columnWidth)
            }
            if column == 2 {
                xOffset.append(columnWidth)
            }
        }
        
        var columnt = 0
        var yOffset = [CGFloat]()
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            for column in 0..<numberOfColumns {
                switch column {
                case 0:
                    yOffset.append(2 * cellPadding)
                case 1:
                    yOffset.append(2 * cellPadding)
                case 2:
                    yOffset.append(cellPadding + cellHeight)
                default:
                    break
                }
            }
        }
    }
    
}
