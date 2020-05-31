//
//  CryptoHandler.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import SwiftHash

/// An object that is responsible for performing cryptographic operations.
class CryptoHandler {
    
    // MARK: - Initialization
    
    init() {}
    
    // MARK: - Methods
    
    /// Returns a String, which contains MD5 hash for the given String.
    func createMD5Hash(from string: String) -> String {
        return MD5(string)
    }
    
}
