//
//  File.swift
//  ProductsAppTests
//
//  Created by Macos on 28/01/2026.
//

import XCTest
@testable import ProductsApp

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<[Product], NetworkError>?
    
    func fetchProducts(limit: Int, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(.unknown))
        }
    }
}
