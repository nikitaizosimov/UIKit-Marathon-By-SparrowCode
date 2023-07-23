//
//  TransformButton.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class TransformButton: UIButton {
    
    // MARK: - Properties
    
    private static var containerScale: CGFloat = 0.97
    private static var animationDuration: Double = 0.25
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: Self.animationDuration,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = self.isHighlighted ?
                CGAffineTransform(scaleX: Self.containerScale, y: Self.containerScale) : .identity
            }
        }
    }
}

