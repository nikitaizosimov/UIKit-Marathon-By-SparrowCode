//
//  ThreeButtonController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class ThreeButtonController: UIViewController {
    
    // MARK: - Properties
    
    private static var sideOffset: CGFloat = 16
    
    // MARK: - Views
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 10
        
        view.addArrangedSubview(firstButton)
        view.addArrangedSubview(secondButton)
        view.addArrangedSubview(thirdButton)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var firstButton: UIButton = { configureButton(title: "First Button") }()
    
    private lazy var secondButton: UIButton = { configureButton(title: "Second Medium Button") }()
    
    private lazy var thirdButton: UIButton = { configureButton(title: "Third", needAction: true) }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Self.sideOffset).isActive = true
        buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Self.sideOffset * 2).isActive = true
    }
    
    // MARK: - Actions
    
    private func configureButton(title: String, needAction: Bool = false) -> TransformButton {
        let button = TransformButton(configuration: .filled(title: title))
        
        button.configurationUpdateHandler = UIButton.blueFillUpdateHandler
        
        if needAction {
            button.addAction(
                UIAction(handler: { [weak self] _ in self?.openModalScreen() }),
                for: .touchUpInside
            )
        }
        
        return button
    }
    
    private func openModalScreen() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        
        present(controller, animated: true)
    }
}
