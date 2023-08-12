//
//  ThreeButtonController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class ThreeButtonController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
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
    
    // MARK: -  Init
    
    init(project pProject: Project) {
        project = pProject
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
    }
    
    // MARK: - Setup Views
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Task",
            primaryAction: UIAction(handler: { [weak self] _ in self?.openTaskPopover() })
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .white
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
    
    private func openTaskPopover() {
        let controller = TaskPopoverController(text: project.description)
        
        controller.modalPresentationStyle = .popover
        
        controller.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.delegate = self
        
        present(controller, animated: true)
    }
}

private extension UIButton.Configuration {
    
    static func filled(title: String) -> Self {
        var configuration = filled()
        
        configuration.title = title
        configuration.image = UIImage(systemName: "arrow.right.circle.fill")
        
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        return configuration
    }
}

private extension UIButton {
    
    static let blueFillUpdateHandler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.tintAdjustmentMode {
        case .dimmed:
            button.configuration?.background.backgroundColor = .systemGray
            button.configuration?.baseForegroundColor = .systemGray2
        default:
            button.configuration?.background.backgroundColor = .systemBlue
            button.configuration?.baseForegroundColor = .white
        }
    }
}

extension ThreeButtonController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
