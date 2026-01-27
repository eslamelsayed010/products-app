//
//  HeaderView.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    static let identifier = "HeaderView"
    
    private var autoScrollTimer: Timer?
    private var currentIndex = 0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var carouselCollectionView: UICollectionView!
    private let images = ["3", "2", "3"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousel()
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bounds.height)
        layout.minimumLineSpacing = 0

        carouselCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.backgroundColor = .clear

        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")

        addSubview(carouselCollectionView)
    }

    override func layoutSubviews() {
            super.layoutSubviews()

            let labelHeight: CGFloat = 30
            let horizontalPadding: CGFloat = 16

            titleLabel.frame = CGRect(
                x: horizontalPadding,
                y: 8,
                width: bounds.width - horizontalPadding * 2,
                height: labelHeight
            )

            let carouselY = titleLabel.frame.maxY 
            carouselCollectionView.frame = CGRect(
                x: 0,
                y: carouselY,
                width: bounds.width,
                height: bounds.height - carouselY
            )

            if let layout = carouselCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = carouselCollectionView.bounds.size
            }
        }


    private func startAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.scrollToNextItem()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }


    private func scrollToNextItem() {
        guard !images.isEmpty else { return }
        
        currentIndex = (currentIndex + 1) % images.count
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    
    public func configure() {
        carouselCollectionView.reloadData()
        startAutoScroll()
    }

}

extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
}

