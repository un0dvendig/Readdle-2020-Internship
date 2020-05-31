//
//  String+CapitalizeFirstLetter.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

extension String {

    /// Returns a String, a copy of the String, but with first letter capitalized.
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    /// Capitalizes first letter of the String.
    mutating func capitalizedFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
    
}
