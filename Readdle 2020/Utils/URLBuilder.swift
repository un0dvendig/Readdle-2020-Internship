//
//  URLBuilder.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A builder object that is responsible for creation of proper URLs.
class URLBuilder {
    
    // MARK: - Properties
    
    private var components: URLComponents
    
    // MARK: - Initialization
    
    init() {
        self.components = URLComponents()
    }
    
    // MARK: - Methods
    
    /// Sets scheme.
    func set(scheme: String) -> URLBuilder {
        self.components.scheme = scheme
        return self
    }
    
    /// Sets host.
    func set(host: String) -> URLBuilder {
        self.components.host = host
        return self
    }
    
    /// Sets path.
    func set(path: String) -> URLBuilder {
        var path = path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.components.path = path
        return self
    }
        
    /// Adds query item. Could be used several times consistently.
    func addQueryItem(name: String, value: String?) -> URLBuilder {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        
        let queryItem = URLQueryItem(name: name, value: value)
        self.components.queryItems?.append(queryItem)
        return self
    }
    
    /// Returns an URL with scheme, host, path and query items (if there were any), which were set previously.
    /// If URL cannot be build, returns nil.
    func build() -> URL? {
        return self.components.url
    }
}
