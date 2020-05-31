//
//  PersonGridCollectionViewCellViewModel.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
import UIKit

struct PersonGridCollectionViewCellViewModel {
    
    // MARK: - Private properties
    
    private let person: Person
    
    // MARK: - Initialization
    
    init(person: Person) {
        self.person = person
    }
    
    // MARK: - Computed properties
    
    var statusColor: UIColor {
        var color: UIColor = .gray
        switch person.status {
        case .online:
            color = .green
        case .offline:
            color = .red
        default:
            break
        }
        return color
    }
    
    var email: String {
        return person.email
    }
    
    var smallImageURL: URL? {
        let hash = DataWorker.shared.createMD5HashForGravatarImageRequestUsing(email: self.email)
        guard let url = URLBuilder()
                        .set(scheme: "https")
                        .set(host: "www.gravatar.com")
                        .set(path: "avatar/\(hash)")
                        .addQueryItem(name: "size", value: "50")
                        .build() else {
            return nil
        }
        return url
    }
    
}
