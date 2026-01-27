//
//  CollectionViewCell.swift
//  ProductsApp
//
//  Created by Macos on 25/01/2026.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    @IBOutlet var lable: UILabel!
    @IBOutlet var image: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with model: Model){
        self.lable.text = model.text
        self.image.image = UIImage(named: model.image)
        self.image.contentMode = .scaleAspectFill
    }
    
}
