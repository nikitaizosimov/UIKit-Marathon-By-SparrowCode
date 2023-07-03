//
//  Project.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

enum Project: CaseIterable {
    
    case gradientAndShadow
    
    var name: String {
        switch self {
        case .gradientAndShadow:
            return "1. Градиент и Тень"
        }
    }
    
    var description: String {
        switch self {
        case .gradientAndShadow:
            return "- Закруглить края.\n- Покрасить градиентом.\n- Установить тень.\n- Вью всегда по центру по вертикали и 100pt от левого края)"
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .gradientAndShadow:
            return GradientAndShadowController()
        }
    }
}
