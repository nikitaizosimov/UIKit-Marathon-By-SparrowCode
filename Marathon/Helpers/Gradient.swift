//
//  Gradient.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

struct Gradient {
    
    let colors: [CGColor]
    
    private(set) var direction: Direction = .diagonalLeftToRight
}

extension Gradient {
    
    enum Direction {
        
        case topToBottom
        case leftToRight
        case diagonalLeftToRight
        case custom(start: CGPoint, end: CGPoint)
        
        var points: (start: CGPoint, end: CGPoint) {
            switch self {
            case .topToBottom:
                return (.zero, CGPoint(x: 0, y: 1))
            case .leftToRight:
                return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1))
            case .diagonalLeftToRight:
                return (.zero, CGPoint(x: 1, y: 1))
            case let .custom(start, end):
                return (start, end)
            }
        }
    }
}
