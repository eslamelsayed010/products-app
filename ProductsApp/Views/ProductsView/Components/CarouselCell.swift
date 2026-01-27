//
//  CarouselCell.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let padding: CGFloat = AppConsts.horizontalPadding

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds.insetBy(
            dx: padding,
            dy: padding
        )
    }

    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
