//
//  ProductCellView.swift
//  ProductsApp
//
//  Created by Macos on 26/01/2026.
//

import UIKit

class ProductCellView: UICollectionViewCell {
    static let identifier = "ProductCellView"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
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
    }
}
