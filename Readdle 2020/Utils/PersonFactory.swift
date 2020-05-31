//
//  PersonFactory.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A singleton object that is responsible for creating new Person entities.
class PersonFactory {
    
    // MARK: - Properties
    
    static let shared = PersonFactory()
    
    // MARK: - Private properties
    
    private let dataGenerator: DataGenerator
    
    // MARK: - Initialization
    
    private init() {
        self.dataGenerator = DataGenerator()
    }
    
    // MARK: - Methods
    
    /// Returns a Person with given name, email and status. By default status is .unknown.
    func createPersonUsing(name: String, email: String, status: Status = .unknown) -> Person {
        let person = Person(name: name, email: email, status: status)
        return person
    }
    
    /// Returns a randomly generated Person, that has .uknown status.
    func createRandomPerson() -> Person {
        let name = dataGenerator.generateName()
        let email = dataGenerator.generateEmail()
        let person = Person(name: name, email: email, status: .unknown)
        return person
    }
    
    /// Returns an array of randomly generated Persons with .unknown status.
    func createRandomPersons(numberOfPersonsToCreate number: Int) -> [Person] {
        var persons: [Person] = []
        guard number > 0 else {
            return persons
        }
        for _ in 0..<number {
            let randomPerson = self.createRandomPerson()
            persons.append(randomPerson)
        }
        return persons
    }
    
}
