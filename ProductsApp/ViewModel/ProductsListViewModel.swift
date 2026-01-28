//
//  ProductsListViewModel.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import Foundation

class ProductsListViewModel {
    private let networkService: NetworkServiceProtocol

    private var allProducts: [Product] = []
    private(set) var products: [Product] = []

    private let pageSize = 7
    private var currentPage = 0
    private var isFetching = false

    var onDataUpdated: (() -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    var onError: ((NetworkError) -> Void)? 

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchInitialProducts() {
        resetPagination()
        fetchAllProducts()
    }

    func fetchMoreProductsIfNeeded(currentIndex: Int) {
        guard currentIndex == products.count - 1 else { return }
        guard !isFetching else { return }
        
        loadNextPage()
    }

    private func fetchAllProducts() {
        isFetching = true
        onLoadingStateChange?(true)

        networkService.fetchProducts(limit: 20) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                self.isFetching = false
                self.onLoadingStateChange?(false)

                switch result {
                case .success(let fetchedProducts):
                    self.allProducts = fetchedProducts
                    self.loadNextPage()

                case .failure(let error):
                    self.onError?(error)
                }
            }
        }
    }
    
    private func loadNextPage() {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allProducts.count)
        
        guard startIndex < allProducts.count else { return }
        
        let newProducts = Array(allProducts[startIndex..<endIndex])
        products.append(contentsOf: newProducts)
        currentPage += 1
        onDataUpdated?()
    }

    private func resetPagination() {
        products.removeAll()
        allProducts.removeAll()
        currentPage = 0
    }
    
    var isLoading: Bool {
        return isFetching && products.isEmpty
    }
}
