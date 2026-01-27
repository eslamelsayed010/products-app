//
//  NetworkServiceTests.swift
//  ProductsAppTests
//
//  Created by Macos on 25/01/2026.
//

import XCTest
@testable import ProductsApp

class NetworkServiceTests: XCTestCase {

    private var mockAPIClient: MockAPIClient!
    private var networkService: NetworkService!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        networkService = NetworkService(apiClient: mockAPIClient)
    }

    override func tearDown() {
        mockAPIClient = nil
        networkService = nil
        super.tearDown()
    }

    // MARK: - Tests
    func testFetchProductsSuccess() {
        let json = """
        [
            {
                "id": 1,
                "title": "Test Product",
                "price": 99.9,
                "description": "Test Description",
                "category": "electronics",
                "image": "https://test.com/image.png",
                "rating": {
                    "rate": 3.9,
                    "count": 70
                }
            }
        ]
        """.data(using: .utf8)!

        mockAPIClient.result = .success(json)

        let expectation = expectation(description: "Fetch products success")

        networkService.fetchProducts(limit: 7) { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "Test Product")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchProductsDecodingFailure() {
        let invalidJSON = """
        { "invalid": "json" }
        """.data(using: .utf8)!

        mockAPIClient.result = .success(invalidJSON)

        let expectation = expectation(description: "Decoding failure")

        networkService.fetchProducts(limit: 7) { result in
            switch result {
            case .success:
                XCTFail("Expected decoding failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .decodingError)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchProductsServerError() {
        mockAPIClient.result = .failure(.serverError(statusCode: 500))

        let expectation = expectation(description: "Server error")

        networkService.fetchProducts(limit: 7) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .serverError(statusCode: 500))
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}

