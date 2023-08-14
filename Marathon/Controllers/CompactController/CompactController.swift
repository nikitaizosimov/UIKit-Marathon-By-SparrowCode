//
//  CompactController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class CompactController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
    // MARK: -  Views
    
    private lazy var buttonLabel: UIButton = {
        let button = UIButton(
            configuration: .plain(),
            primaryAction: UIAction(handler: { [weak self] _ in self?.openPopoverController() })
        )
        
        button.configuration?.title = "Present"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Task",
            primaryAction: UIAction(handler: { [weak self] _ in self?.openTaskPopover() })
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(buttonLabel)
        
        buttonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    private func openPopoverController() {
        let controller = CompactPopoverController()
        
        controller.modalPresentationStyle = .popover
        
        controller.popoverPresentationController?.sourceView = buttonLabel
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.delegate = self
        
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

extension CompactController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
