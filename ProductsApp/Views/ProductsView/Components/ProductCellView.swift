//
//  ProductCellView.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit
import SDWebImage

class ProductCellView: UICollectionViewCell {
    static let identifier = "ProductCellView"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var starIcon: UIImageView!
    
    private let imageSkeleton = SkeletonView()
    private let titleSkeleton = SkeletonView()
    private let rateSkeleton = SkeletonView()
    private let priceSkeleton = SkeletonView()
    
    private var isShowingSkeleton = false
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductCellView", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true

        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail

        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        setupSkeletonViews()
    }
    
    private func setupSkeletonViews() {
        imageSkeleton.layer.cornerRadius = 20
        
        [imageSkeleton, titleSkeleton, rateSkeleton, priceSkeleton].forEach {
            $0.isHidden = true
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isShowingSkeleton {
            layoutSkeletonViews()
        }
    }
    
    private func layoutSkeletonViews() {
        imageSkeleton.frame = imageView.frame
        
        titleSkeleton.frame = CGRect(
            x: title.frame.origin.x,
            y: title.frame.origin.y,
            width: title.frame.width,
            height: 16
        )
        
        rateSkeleton.frame = CGRect(
            x: rate.frame.origin.x,
            y: rate.frame.origin.y,
            width: 60,
            height: 14
        )
        
        priceSkeleton.frame = CGRect(
            x: price.frame.origin.x,
            y: price.frame.origin.y,
            width: 80,
            height: 16
        )
    }
    
    func showSkeleton() {
        isShowingSkeleton = true
        
        imageView.isHidden = true
        title.isHidden = true
        rate.isHidden = true
        count.isHidden = true
        price.isHidden = true
        starIcon.isHidden = true
        
        [imageSkeleton, titleSkeleton, rateSkeleton, priceSkeleton].forEach {
            $0.isHidden = false
            $0.startAnimating()
        }
        
        layoutSkeletonViews()
    }
    
    func hideSkeleton() {
        isShowingSkeleton = false
        
        [imageSkeleton, titleSkeleton, rateSkeleton, priceSkeleton].forEach {
            $0.stopAnimating()
            $0.isHidden = true
        }
        
        imageView.isHidden = false
        title.isHidden = false
        rate.isHidden = false
        count.isHidden = false
        price.isHidden = false
        starIcon.isHidden = false
    }
    
    public func configure(_ product: Product) {
        hideSkeleton()
        
        self.title.text = product.title
        self.rate.text = String(product.rating.rate)
        self.count.text = "(\(String(product.rating.count)))"
        self.price.text = "EGP " + String(product.price)
        
        imageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "2"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
        imageView.image = nil
        title.text = nil
        rate.text = nil
        count.text = nil
        price.text = nil
    }
}
