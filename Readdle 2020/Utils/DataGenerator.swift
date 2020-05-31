//
//  DataGenerator.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Fakery

/// An object that is responsible for generating fake data.
class DataGenerator {
    
    // MARK: - Private properties
    
    private let faker: Faker
    
    // MARK: - Initialization
    
    init() {
        self.faker = Faker()
    }
    
    // MARK: - Methods
    
    func generateEmail() -> String {
        return faker.internet.freeEmail()
    }
    
    func generateName() -> String {
        return faker.name.name()
    }
    
}
