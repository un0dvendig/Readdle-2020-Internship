//
//  DownloadManager.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// A singleton object that is responsible for data downloading. Basically, an abstraction layer on top of URLSession.
class DownloadManager {
    
    // MARK: - Properties
    
    static let shared = DownloadManager()
    
    // MARK: - Private properties
    
    private let session: URLSession
    
    // MARK: - Initialization
    
    private init() {
        self.session = URLSession.shared
    }
    
    // MARK: - Methods
    
    /// Downloads Data from the given URL using completion.
    func downloadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.hasSuccessStatusCode,
                let data = data {
                completion(.success(data))
            } else {
                let error = CustomError.errorWithText("Data or response error")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
