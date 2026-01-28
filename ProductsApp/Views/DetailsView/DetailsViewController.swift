//
//  DetailsViewController.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import UIKit

class DetailsViewController: UIViewController {
    var product: Product?
    
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var viewProductButton: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBAction func viewProductTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
        displayProduct()
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
    
    private func displayProduct() {
        guard let product = product else { return }
        productTitle.text = product.title
        productDesc.text = product.description
        category.text = product.category
        productRate.text = "\(product.rating.rate)"
        ratingsCount.text = "\(product.rating.count)"
        
        if product.image.starts(with: "http") {
            productImage.sd_setImage(
                with: URL(string: product.image),
                placeholderImage: UIImage(named: "2"),
                options: [.progressiveLoad, .retryFailed]
            )
        } else {
            productImage.image = UIImage(named: product.image)
        }
    }
}
