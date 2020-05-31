//
//  PersonsWarehouse.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A singleton object that is responsible for storing and managing all Person entities.
class PersonsWarehouse {
    
    // MARK: - Properties

    static let shared = PersonsWarehouse()
    
    // MARK: - Private properties
    
    private let queue = DispatchQueue(label: "un0dvend1g.Readdle-2020.personsWarehouse.backgroundQueue", qos: .background, attributes: .concurrent)
    private let personFactory: PersonFactory
    private var persons: [Person]
    
    // MARK: - Initialization
    
    private init() {
        self.personFactory = PersonFactory.shared
        self.persons = personFactory.createRandomPersons(numberOfPersonsToCreate: 30)
    }
    
    // MARK: - Computed properties
    
    dynamic var totalNumberOfPersons: Int {
        return persons.count
    }
    
    // MARK: - Methods
    
    /// Returns all available Person entities.
    func getAllPersons() -> [Person] {
        var availablePersons: [Person] = []
        queue.sync {
            availablePersons = persons
        }
        return availablePersons
    }
    
    /// Return a Person entity at given index. If no found, returns nil.
    func getPerson(at index: Int) -> Person? {
        guard index < persons.count else {
            return nil
        }
        var person: Person? = nil
        queue.sync {
            person = persons[index]
        }
        return person
    }
    
    /// Adds a new random Person to the array of available Person entities..
    func addRandomPerson() {
        let person = personFactory.createRandomPerson()
        queue.async(flags: .barrier) {
            self.persons.append(person)
        }
    }
    
    /// Deletes random Person entity.
    func deleteRandomPerson() {
        let randomIndex = Int(arc4random_uniform(UInt32(self.persons.count)))
        queue.async(flags: .barrier) {
            self.persons.remove(at: randomIndex)
        }
    }
    
    /// Shuffles all available Person entities.
    func shufflePersons() {
        queue.async(flags: .barrier) {
            self.persons.shuffle()
        }
    }
    
    // TODO: - Add method for "Simulate changes" button.
    
}
