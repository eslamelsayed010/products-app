//
//  CarouselCell.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import UIKit
import SDWebImage

class CarouselCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let skeletonView = SkeletonView()
    private let padding: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        
        skeletonView.layer.cornerRadius = 20
        skeletonView.isHidden = true
        contentView.addSubview(skeletonView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let insetBounds = contentView.bounds.insetBy(dx: padding, dy: padding)
        imageView.frame = insetBounds
        skeletonView.frame = insetBounds
    }
    
    func showSkeleton() {
        imageView.isHidden = true
        skeletonView.isHidden = false
        skeletonView.startAnimating()
    }
    
    func hideSkeleton() {
        skeletonView.stopAnimating()
        skeletonView.isHidden = true
        imageView.isHidden = false
    }

    func configure(with imageUrl: String) {
        if imageUrl.isEmpty {
            showSkeleton()
            return
        }
        
        hideSkeleton()
        
        if imageUrl.starts(with: "http") {
            imageView.sd_setImage(
                with: URL(string: imageUrl),
                placeholderImage: UIImage(named: "2"),
                options: [.progressiveLoad, .retryFailed]
            )
        } else {
            imageView.image = UIImage(named: imageUrl)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
        imageView.image = nil
    }
}
