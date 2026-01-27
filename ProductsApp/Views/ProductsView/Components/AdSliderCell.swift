//
//  AdSliderCell.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

final class AdSliderCell: UICollectionViewCell {

    static let identifier = "AdSliderCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    func configure(image: UIImage?) {
        imageView.image = image
    }
}


