//
//  Person+Equatable.swift
//  Readdle 2020 Tests
//
//  Created by Eugene Ilyin on 31.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
@testable import Readdle_2020

extension Person: Equatable {
    
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
            && lhs.email == rhs.email
            && lhs.status == rhs.status
    }
    
}
