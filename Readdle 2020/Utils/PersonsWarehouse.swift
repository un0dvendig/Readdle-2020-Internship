//
//  PersonsWarehouse.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A singleton object that is responsible for storing and managing all Person entities.
/// By default has `100` entities.
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
        self.persons = []
    }
    
    // MARK: - Computed properties
    
    dynamic var totalNumberOfPersons: Int {
        get {
            queue.sync {
                return self.persons.count
            }
        }
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
    
    /// Returns a Person entity at given index. If no found, returns nil.
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
    
    /// Adds a new random Person to the end of the array of available Person entities.
    func addRandomPerson() {
        let person = personFactory.createRandomPerson()
        queue.async(flags: .barrier) {
            self.persons.append(person)
        }
    }
    
    /// Adds several new random Person entities to the end of the aray of available Person entities.
    func addSeveralRandomPersons(numberOfPersons number: Int) {
        let persons = personFactory.createRandomPersons(numberOfPersonsToCreate: number)
        queue.async(flags: .barrier) {
            self.persons.append(contentsOf: persons)
        }
    }
    
    /// Adds the Person to the end of the array of available Person entities.
    func addPerson(_ person: Person) {
        queue.async(flags: .barrier) {
            self.persons.append(person)
        }
    }
    
    /// Replaces a Person entity at given index with the given Person.
    /// If the index is out of range, nothing will happen.
    func changePerson(at index: Int, to person: Person) {
        queue.async(flags: .barrier) {
            guard index < self.persons.count else {
                return
            }
            self.persons[index] = person
        }
    }
    
    /// Changes Person entity info at given index with the given info.
    /// If the index is out of range, nothing will happen.
    func changePersonInfo(atIndex index: Int, name: String, email: String, status: Status) {
        queue.async(flags: .barrier) {
            guard index < self.persons.count else {
                return
            }
            let person = self.persons[index]
            person.name = name
            person.email = email
            person.status = status
            self.persons[index] = person
        }
    }
    
    /// Deletes random Person entity.
    func deleteRandomPerson() {
        queue.async(flags: .barrier) {
            let randomIndex = Int(arc4random_uniform(UInt32(self.persons.count)))
            self.persons.remove(at: randomIndex)
        }
    }
    
    /// Deletes Person entity at given index.
    /// If the index is out of range, nothing will happen.
    func deletePerson(at index: Int) {
        queue.async(flags: .barrier) {
            guard index < self.persons.count else {
                return
            }
            self.persons.remove(at: index)
        }
    }
    
    /// Shuffles all available Person entities.
    func shufflePersons() {
        queue.async(flags: .barrier) {
            self.persons.shuffle()
        }
    }
    
    /// Deletes all available Person entities.
    func deleteAllPersons() {
        queue.async(flags: .barrier) {
            self.persons = []
        }
    }
    
    /// Simulates huge changes to all available Person entities.
    func simulateChanges() {
        self.shufflePersons()
        
        let numberOfDeletions = Int.random(in: 1...10)
        let numberOfAdditions = Int.random(in: 1...10)
        let numberOfReplacements = Int.random(in: (persons.count / 2)...persons.count)
        let numberOfInfoChange = Int.random(in: 1...10)
        
        for _ in 0..<numberOfDeletions {
            self.deleteRandomPerson()
        }
        
        for _ in 0..<numberOfAdditions {
            self.addRandomPerson()
        }
        
        for _ in 0..<numberOfReplacements {
            let randomNumber = Int.random(in: 1...persons.count)
            let person = PersonFactory.shared.createRandomPerson()
            self.changePerson(at: randomNumber, to: person)
        }
        
        for _ in 0..<numberOfInfoChange {
            let randomNumber = Int.random(in: 1...persons.count)
            let randomPerson = PersonFactory.shared.createRandomPerson()
            self.changePersonInfo(atIndex: randomNumber,
                                  name: randomPerson.name,
                                  email: randomPerson.email,
                                  status: randomPerson.status)
        }
        
        self.shufflePersons()
    }
}
