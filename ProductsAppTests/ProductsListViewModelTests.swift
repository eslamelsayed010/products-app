//
//  ProductsListViewModelTests.swift
//  ProductsAppTests
//
//  Created by Macos on 28/01/2026.
//

import XCTest
@testable import ProductsApp

class ProductsListViewModelTests: XCTestCase {
    
    private var viewModel: ProductsListViewModel!
    private var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = ProductsListViewModel(networkService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchInitialProductsSuccess() {
        // Given
        let products = (1...10).map { Product(id: $0, title: "Product \($0)", price: Double($0), description: "", category: "", image: "", rating: Rating(rate: 4.0, count: 10)) }
        
        mockService.result = .success(products)
        
        let expectationDataUpdated = expectation(description: "onDataUpdated called")
        viewModel.onDataUpdated = {
            expectationDataUpdated.fulfill()
        }
        
        // When
        viewModel.fetchInitialProducts()
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.products.count, 7, "Should load first page with 7 items")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
    }
    
    func testFetchInitialProductsFailure() {
        // Given
        mockService.result = .failure(.serverError(statusCode: 500))
        let expectationError = expectation(description: "onError called")
        viewModel.onError = { error in
            XCTAssertEqual(error, .serverError(statusCode: 500))
            expectationError.fulfill()
        }
        
        // When
        viewModel.fetchInitialProducts()
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(viewModel.products.isEmpty, "Products should remain empty on failure")
    }
}
