//
//  NetworkService.swift
//  ProductsApp
//
//  Created by Macos on 23/01/2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchProducts(
        limit: Int,
        completion: @escaping (Result<[Product], NetworkError>) -> Void
    )
}

class NetworkService: NetworkServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchProducts(
        limit: Int,
        completion: @escaping (Result<[Product], NetworkError>) -> Void
    ) {
        var components = URLComponents(string: APIConstants.baseURL.rawValue + APIConstants.products.rawValue)
        
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        guard let url = components?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        apiClient.request(url: url, completion: completion)
    }
}
