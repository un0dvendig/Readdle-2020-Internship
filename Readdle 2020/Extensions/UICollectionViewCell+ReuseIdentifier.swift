//
//  UICollectionViewCell.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    /// A computed String class property that helps to reguster / user cell.
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
