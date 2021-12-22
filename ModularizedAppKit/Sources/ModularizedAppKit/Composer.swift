//
//  File.swift
//  
//
//  Created by Riccardo Cipolleschi on 22/12/21.
//

import Foundation
import RepositoryDetails
import UIKit
import Networking

public struct Composer {
    public static var repositoryDetailsView: UIViewController {
        return RepositoryDetailsViewController(repositoryService: LiveRepositoryService())
    }
}

struct LiveRepositoryService: RepositoryService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = LiveNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getRepository(for id: String, callback: @escaping (Result<Repository, Error>) -> Void) {
        let url = URL(string: "https://mocki.io/v1/\(id)")!
        self.networkManager.get(url: url, callback: callback)
    }
}
