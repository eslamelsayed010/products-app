//
//  ProductViewController.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

class ProductsViewController: UIViewController {
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/2.2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(ProductCellView.nib(), forCellWithReuseIdentifier: ProductCellView.identifier)
        collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView!)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
}

extension ProductsViewController: UICollectionViewDelegate {}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.identifier, for: indexPath) as! ProductCellView
        
        return cell
    }
}
