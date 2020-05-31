//
//  HTTPURLResponse+HasSuccessStatusCode.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    /// A computed Boolean property that indicates whether the reponse has successful status code.
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
