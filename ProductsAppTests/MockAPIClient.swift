//
//  MockAPIClient.swift
//  ProductsAppTests
//
//  Created by Macos on 25/01/2026.
//

import Foundation
@testable import ProductsApp

class MockAPIClient: APIClientProtocol {

    var result: Result<Data, NetworkError>?

    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let result = result else {
            completion(.failure(.unknown))
            return
        }

        switch result {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }
}
