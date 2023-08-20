//
//  RelatedAnimationController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

class RelatedAnimationController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
    let animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeOut)
    
    // MARK: - Views
    
    private lazy var squareView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private lazy var sliderView: UISlider = {
        let view = UISlider()
        
        view.addAction(
            UIAction(handler: { [weak self] _ in
                self?.animator.fractionComplete = CGFloat(self?.sliderView.value ?? 0)
            }),
            for: .valueChanged
        )
        
        view.addAction(
            UIAction(handler: { [weak self] _ in
                self?.animator.startAnimation()
                self?.sliderView.value = 1
            }),
            for: [.touchUpInside, .touchUpOutside]
        )
        
        return view
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
        
        setupNavigationBar()
        setupViews()
        setupAnimator()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard squareView.transform == .identity else { return }
        
        squareView.frame = .init(x: view.layoutMargins.left, y: 110, width: 80, height: 80)
        
        sliderView.sizeToFit()
        sliderView.frame = .init(
            x: view.layoutMargins.left,
            y: squareView.frame.maxY + 44,
            width: view.frame.width - (view.layoutMargins.left * 2),
            height: 80
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        animator.stopAnimation(true)
        
        if animator.state != .inactive {
            animator.finishAnimation(at: .current)
        }
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
        view.addSubview(sliderView)
    }
    
    private func setupAnimator() {
        animator.pausesOnCompletion = true
        
        animator.addAnimations {
            self.squareView.frame.origin.x = self.view.frame.width - (self.view.layoutMargins.right * 2) - self.squareView.frame.width
            self.squareView.transform = .identity.scaledBy(x: 1.5, y: 1.5).rotated(by: .pi / 2)
        }
    }
    
    // MARK: - Actions
    
    private func openTaskPopover() {
        let controller = TaskPopoverController(text: project.description)
        
        controller.modalPresentationStyle = .popover
        
        controller.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.delegate = self
        
        present(controller, animated: true)
    }
}

extension RelatedAnimationController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
