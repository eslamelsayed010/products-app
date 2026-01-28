//
//  ProductViewController.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

class ProductsViewController: UIViewController {
    var collectionView: UICollectionView?
    private let apiClient: APIClientProtocol = APIClient()

    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService(apiClient: apiClient)
    }()

    private lazy var viewModel: ProductsListViewModel = {
        ProductsListViewModel(networkService: networkService)
    }()

    
    private let productsLabel: UILabel = {
        let label = UILabel()
        label.text = "Products"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let cartImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        let image = UIImage(systemName: "cart.fill", withConfiguration: config)
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productsLabel)
        view.addSubview(cartImageView)
        setupCollectionView(layout: setupLayout())
        bindViewModel()
        viewModel.fetchInitialProducts()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let labelHeight: CGFloat = 40
        let topPadding: CGFloat = view.safeAreaInsets.top + 8
        let horizontalPadding: CGFloat = 16
        let cartImageSize: CGFloat = 30
        let spacing: CGFloat = 8
        
        cartImageView.frame = CGRect(
            x: view.bounds.width - horizontalPadding - cartImageSize,
            y: topPadding + 5,
            width: cartImageSize,
            height: cartImageSize
        )
        
        productsLabel.frame = CGRect(
            x: horizontalPadding,
            y: topPadding,
            width: view.bounds.width - (horizontalPadding * 2) - cartImageSize - spacing,
            height: labelHeight
        )
        
        collectionView?.frame = CGRect(
            x: 0,
            y: productsLabel.frame.maxY + 8,
            width: view.bounds.width,
            height: view.bounds.height - productsLabel.frame.maxY - 8
        )
    }
    
    
    private func setupCollectionView(layout: UICollectionViewFlowLayout) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(ProductCellView.nib(), forCellWithReuseIdentifier: ProductCellView.identifier)
        
        collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView!)
    }
    
    private func setupLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let width = (view.frame.width - 30) / 2
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
        
        if viewModel.isLoading {
            header.configure(with: ["", "", ""])
        } else {
            let carouselImages = viewModel.products.prefix(7).map { $0.image }
            header.configure(with: Array(carouselImages))
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 350)
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.isLoading ? 6 : viewModel.products.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if !viewModel.isLoading {
            viewModel.fetchMoreProductsIfNeeded(currentIndex: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.identifier, for: indexPath) as! ProductCellView
        
        if viewModel.isLoading {
            cell.showSkeleton()
        } else {
            cell.configure(viewModel.products[indexPath.row])
        }
        
        return cell
    }
}
