//
//  InertialSquareController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class InertialSquareController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
    // MARK: - Views
    
    private lazy var squareView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        
        view.bounds.size = .init(width: 100, height: 100)
        
        return view
    }()
    
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
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
        
        setupNavigationBar()
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        animateSquare(with: touch.location(in: view))
    }
    
    // MARK: - SetupViews
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Task",
            primaryAction: UIAction(handler: { [weak self] _ in self?.openTaskPopover() })
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        squareView.frame.origin = .init(x: view.bounds.width / 2 - 50, y: view.bounds.height / 2 - 50)
    }
    
    // MARK: - Actions
    
    private func animateSquare(with location: CGPoint) {
        animator.removeAllBehaviors()
        
        let snapBehavior = UISnapBehavior(item: squareView, snapTo: location)
        snapBehavior.damping = 0.9
        
        animator.addBehavior(snapBehavior)
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

extension InertialSquareController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
