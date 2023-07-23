//
//  GradientAndShadowController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class GradientAndShadowController: UIViewController {
    
    // MARK: - Properties
    
    private static var squareViewSize = CGSize(width: 100, height: 100)
    
    // MARK: - Views
    
    private lazy var squareView: SquareView = {
        let view = SquareView()
        
        view.widthAnchor.constraint(equalToConstant: Self.squareViewSize.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: Self.squareViewSize.height).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(squareView)
        squareView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Action
    
    private func openTaskPopover() {
        let controller = TaskPopoverController(text: "23232")
        
        controller.modalPresentationStyle = .popover
        
        controller.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.delegate = self
        
        present(controller, animated: true)
    }
}

extension GradientAndShadowController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
