//
//  NetworkError.swift
//  ProductsApp
//
//  Created by Macos on 23/01/2026.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
    case noInternet
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .serverError(let code):
            return "Server error with status code \(code)"
        case .decodingError:
            return "Failed to decode data"
        case .noInternet:
            return "No internet connection"
        case .unknown:
            return "Something went wrong"
        }
    }
}
