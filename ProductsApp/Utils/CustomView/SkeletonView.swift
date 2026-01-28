//
//  SkeletonView.swift
//  ProductsApp
//
//  Created by Macos on 27/01/2026.
//

import UIKit

class SkeletonView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSkeleton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSkeleton()
    }
    
    private func setupSkeleton() {
        backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let lightColor = UIColor(white: 0.90, alpha: 1.0).cgColor
        let darkColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        
        gradientLayer.colors = [darkColor, lightColor, darkColor]
        gradientLayer.locations = [0, 0.5, 1]
        
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }
    
    func stopAnimating() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}
