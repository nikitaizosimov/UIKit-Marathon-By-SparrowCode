//
//  Project.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

enum Project: CaseIterable {
    
    case gradientAndShadow
    case threeButton
    
    var name: String {
        switch self {
        case .gradientAndShadow:
            return "1. Градиент и тень"
        case .threeButton:
            return "2. Три кнопки"
        }
    }
    
    var description: String {
        switch self {
        case .gradientAndShadow:
            return "- Закруглить края.\n- Покрасить градиентом.\n- Установить тень.\n- Вью всегда по центру по вертикали и 100pt от левого края)"
        case .threeButton:
            return """
                    - Кнопки должны быть адаптивные, под разный текст - разная ширина. Отступ внутри кнопки от контента 10pt по вертикали и 14pt по горизонтали.
                    - По нажатию анимировано уменьшать кнопку. Когда отпускаешь - кнопка возвращается к оригинальному размеру. Анимация должна быть прерываемая, например, кнопка возвращается к своему размеру, а в процессе анимации снова нажать на кнопку - анимация пойдет из текущего размера, без скачков.
                    - Справа от текста поставить иконку. Использовать системный imageView в классе кнопки, создавать свою imageView нельзя. Расстояние между текстом и иконкой 8pt.
                    - Когда показывается модальный контроллер, кнопки должны закрашиваться серым. Нельзя привязываться к методам жизненного цикла контроллера.
                    """
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .gradientAndShadow:
            return GradientAndShadowController()
        case .threeButton:
            return UIViewController()
        }
    }
}