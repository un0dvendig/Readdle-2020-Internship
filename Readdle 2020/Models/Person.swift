//
//  Person.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

class Person {
    
    // MARK: - Properties
    
    var name: String
    var email: String
    var status: Status
    
    // MARK: - Initialization
    
    init(name: String, email: String, status: Status = .unknown) {
        self.name = name
        self.email = email
        self.status = status
    }
    
}
