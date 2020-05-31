//
//  DataWorker.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

/// A singleton object that is responsible for data conversion.
class DataWorker {
    
    // MARK: - Properties
    
    static let shared = DataWorker()
    
    // MARK: - Private properties
    
    private let cryptoHandler: CryptoHandler
    
    // MARK: - Initialization
    
    private init() {
        self.cryptoHandler = CryptoHandler()
    }
    
    // MARK: - Methods
    
    /// Returns a String, which contains MD5 hash value for the given email
    /// according to: http://en.gravatar.com/site/implement/hash/.
    func createMD5HashForGravatarImageRequestUsing(email: String) -> String {
        let clearEmailString = email.trimmingCharacters(in: .whitespaces).lowercased()
        return cryptoHandler.createMD5Hash(from: clearEmailString)
    }
    
    /// Tries to convert given Data to UIImage. Returns optional UIImage.
    func convertDataToUIImage(_ data: Data) -> UIImage? {
        let image = UIImage(data: data)
        return image
    }
    
}
