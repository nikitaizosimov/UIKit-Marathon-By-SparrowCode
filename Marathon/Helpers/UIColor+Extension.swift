//
//  UIColor+Extension.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

extension UIColor {
    
    static func rgb(_ red: CGFloat,
                    _ green: CGFloat,
                    _ blue: CGFloat,
                    alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255,
                       green: green / 255,
                       blue: blue / 255,
                       alpha: alpha)
    }
}

