//
//  ProductViewController.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

class ProductsViewController: UIViewController {
    var collectionView: UICollectionView?
    
    private let productsLabel: UILabel = {
        let label = UILabel()
        label.text = "Products"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productsLabel)
        setupCollectionView(layout: setupLayout())
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let labelHeight: CGFloat = 40
        let topPadding: CGFloat = view.safeAreaInsets.top + 8
        
        productsLabel.frame = CGRect(
            x: 16,
            y: topPadding,
            width: view.bounds.width - 32,
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
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 250)
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.identifier, for: indexPath) as! ProductCellView
        
        return cell
    }
}
