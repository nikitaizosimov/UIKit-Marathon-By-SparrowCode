//
//  SquareView.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class SquareView: UIView {
    
    // MARK: - Properties
    
    private static let firstColor = UIColor.rgb(72, 136, 182).cgColor
    private static let secondColor = UIColor.rgb(250, 32, 36).cgColor
    
    private lazy var squareGradient: Gradient = {
        Gradient(colors: [Self.firstColor, Self.secondColor])
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        layer.colors = squareGradient.colors
        layer.startPoint = squareGradient.direction.points.start
        layer.endPoint = squareGradient.direction.points.end
        
        layer.cornerRadius = 12
        
        return layer
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    // MARK: - Common Init
    
    private func commonInit() {
        shadowRadius = 10
        
        layer.addSublayer(gradientLayer)
    }
}
