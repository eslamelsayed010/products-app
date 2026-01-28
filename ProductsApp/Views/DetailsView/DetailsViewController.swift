//
//  DetailsViewController.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var viewProductButton: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBAction func viewProductTapped(_ sender: Any) {
        print("TAPED")
    }
    @IBOutlet weak var categoryContainer: UIView!
    @IBOutlet weak var productRate: UILabel!
    
    @IBOutlet weak var ratingsCount: UILabel!
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryContainer()
        roundBottomCornersOfImage()
    }
    
    private func setupCategoryContainer() {
        categoryContainer.layer.cornerRadius = 20
        categoryContainer.layer.masksToBounds = true
    }
    
    private func roundBottomCornersOfImage() {
        productImage.layer.cornerRadius = 24
        productImage.layer.maskedCorners = [
            .layerMinXMaxYCorner, 
            .layerMaxXMaxYCorner
        ]
        productImage.layer.masksToBounds = true
        viewProductButton.configuration?.imagePadding = 8
    }

}
