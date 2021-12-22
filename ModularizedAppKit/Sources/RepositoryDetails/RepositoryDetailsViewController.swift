//
//  File.swift
//  
//
//  Created by Riccardo Cipolleschi on 22/12/21.
//

import UIKit

// MARK: - Model
public struct Repository: Decodable {
    let name: String
    let description: String
    
    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

// MARK: - Service
public protocol RepositoryService {
    func getRepository(for id: String, callback: @escaping (Result<Repository, Error>) -> Void)
}

// MARK: - ViewController
public class RepositoryDetailsViewController: UIViewController {
    var repositoryService: RepositoryService
    
    var rootView: RepositoryDetailsView {
        return self.view as! RepositoryDetailsView
    }
    
    public init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    public override func loadView() {
        self.view = RepositoryDetailsView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repositoryService.getRepository(for: "0fe46042-1646-4864-a60e-e498bb67aaa9") { result in
            switch result {
            case .success(let repository):
                DispatchQueue.main.async {
                    self.rootView.update(with: repository)
                }
            case .failure(let error):
                print("An error as occurred: \(error)")
            }
        }
    }
}

class RepositoryDetailsView: UIView {
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setup()
        self.style()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup(){
        self.addSubview(self.nameLabel)
        self.addSubview(self.descriptionLabel)
    }
    
    func style(){
        self.backgroundColor = .systemBackground
        
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        self.descriptionLabel.textColor = .systemGray
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.numberOfLines = 0
        
    }
    
    func setupConstraints(){
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor)
        ])
    }
    
    func update(with repository: Repository) {
        self.nameLabel.text = repository.name
        self.descriptionLabel.text = repository.description
    }
    
}
