//
//  APIClient.swift
//  ProductsApp
//
//  Created by Macos on 23/01/2026.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

class APIClient: APIClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                // Check if it's a network connectivity issue
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                    case NSURLErrorNotConnectedToInternet,
                         NSURLErrorNetworkConnectionLost,
                         NSURLErrorDataNotAllowed:
                        completion(.failure(.noInternet))
                        return
                    default:
                        break
                    }
                }
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
