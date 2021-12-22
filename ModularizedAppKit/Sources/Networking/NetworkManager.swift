//
//  File.swift
//  
//
//  Created by Riccardo Cipolleschi on 22/12/21.
//

import Foundation

public protocol NetworkManager {
    func get<T: Decodable>(url: URL, callback: @escaping (Result<T, Error>) -> Void)
}

public struct LiveNetworkManager: NetworkManager {
    
    let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func get<T: Decodable>(url: URL, callback: @escaping (Result<T, Error>) -> Void) {
        self.urlSession.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let decoded = try? JSONDecoder().decode(T.self, from: data)
            else {
                // We should handle errors better
                callback(.failure(NSError(domain: "Networking", code: -1, userInfo: [:])))
                return
            }
            callback(.success(decoded))
            
        }.resume()
    }
    
    
}
