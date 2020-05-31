//
//  DetailedInfoViewModel.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

struct DetailedInfoViewModel {
    
    // MARK: - Private properties
    
    private let person: Person
    
    // MARK: - Initialization
    
    init(person: Person) {
        self.person = person
    }
    
    // MARK: - Computed properties
    
    var name: String {
        return person.name
    }
    
    var status: String {
        return person.status.rawValue
    }
    
    var email: String {
        return person.email
    }
    
    var largeImageURL: URL? {
        let hash = DataWorker.shared.createMD5HashForGravatarImageRequestUsing(email: self.email)
        guard let url = URLBuilder()
                        .set(scheme: "https")
                        .set(host: "www.gravatar.com")
                        .set(path: "avatar/\(hash)")
                        .addQueryItem(name: "size", value: "400")
                        .build() else {
            return nil
        }
        return url
    }
    
}
