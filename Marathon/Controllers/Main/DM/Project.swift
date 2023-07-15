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
    case relatedAnimation
    case mixerTable
    case compactController
    case inertialSquare
    case stretchingPicture
    
    var name: String {
        switch self {
        case .gradientAndShadow:
            return "1. Градиент и тень"
        case .threeButton:
            return "2. Три кнопки"
        case .relatedAnimation:
            return "3. Связанная анимация"
        case .mixerTable:
            return "4. Миксер-Таблица"
        case .compactController:
            return "5. Компактный Контроллер"
        case .inertialSquare:
            return "6. Инерционный Квадрат"
        case .stretchingPicture:
            return "7. Растягивающаяся Картинка"
        }
    }
    
    var description: String {
        switch self {
        case .gradientAndShadow:
            return """
                    - Закруглить края.
                    - Покрасить градиентом.
                    - Установить тень.
                    - Вью всегда по центру по вертикали и 100pt от левого края)
                    """
        case .threeButton:
            return """
                    - Кнопки должны быть адаптивные, под разный текст - разная ширина. Отступ внутри кнопки от контента 10pt по вертикали и 14pt по горизонтали.
                    - По нажатию анимировано уменьшать кнопку. Когда отпускаешь - кнопка возвращается к оригинальному размеру. Анимация должна быть прерываемая, например, кнопка возвращается к своему размеру, а в процессе анимации снова нажать на кнопку - анимация пойдет из текущего размера, без скачков.
                    - Справа от текста поставить иконку. Использовать системный imageView в классе кнопки, создавать свою imageView нельзя. Расстояние между текстом и иконкой 8pt.
                    - Когда показывается модальный контроллер, кнопки должны закрашиваться серым. Нельзя привязываться к методам жизненного цикла контроллера.
                    """
        case .relatedAnimation:
            return """
                    - В конечной точке вью должна быть справа (минус отступ), увеличится в 1.5 раза и повернуться на 90 градусов.
                    - Когда отпускаем слайдер, анимация идет до конца с текущего места.
                    - Слева и справа отступы layout margins. Отступ как для квадратной вью, так и для слайдера.
                    """
        case .mixerTable:
            return """
                    - По нажатию на ячейку она анимировано перемещается на первое место, а справа появляется галочка.
                    - Если нажать на ячейку с галочкой, то галочка пропадает.
                    - Справа вверху кнопка анимировано перемешивает ячейки.
                    """
        case .compactController:
            return """
                    - Контроллер открывается не на весь экран. Ширина всегда 300pt.
                    - По умолчанию выбран первый пункт с высотой 280pt. Если выбрать второй пункт - высота станет 150pt. Высота меняется анимировано.
                    - Кнопка закрыть в правом верхнем углу закрывает контроллер.
                    - Контроллер сверху привязан к центру кнопки треугольничком (см. видео).
                    """
        case .inertialSquare:
            return """
                    - Квадрат должен двигаться как физический объект - если проходит большое расстояние, то есть отскок с инерцией.
                    - Есть небольшой поворот квадрата при движении в новую точку.
                    """
        case .stretchingPicture:
            return """
                    - Если скролить вниз, то картинка растягивается. Верхний край прикреплен к верхей части экрана.
                    - Если скролить вверх, картинка уходит наверх вместе со скролом.
                    - Индикатор скрола (полоска справа) всегда находится ниже картинки и не должен залазить на неё.
                    """
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .gradientAndShadow:
            return GradientAndShadowController()
        case .threeButton:
            return ThreeButtonController()
        case .relatedAnimation:
            return RelatedAnimationController()
        case .mixerTable:
            return MixerTableController()
        case .compactController:
            return CompactController()
        case .inertialSquare:
            return InertialSquareController()
        case .stretchingPicture:
            return StretchingPictureController()
        }
    }
}
