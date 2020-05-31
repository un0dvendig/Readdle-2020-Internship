//
//  Protocols.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 31.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

protocol ErrorHandlerDelegate {
    
    // MARK: - Protocol methods
    
    func didGetAnError(_ error: Error, description: String)
    
}
