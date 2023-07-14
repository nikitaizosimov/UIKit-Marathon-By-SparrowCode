//
//  InertialSquareController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class InertialSquareController: UIViewController {
    
    // MARK: - Views
    
    private lazy var squareView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        
        view.bounds.size = .init(width: 100, height: 100)
        
        return view
    }()
    
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        animateSquare(with: touch.location(in: view))
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        squareView.frame.origin = .init(x: view.bounds.width / 2 - 50, y: view.bounds.height / 2 - 50)
    }
    
    // MARK: - Actions
    
    private func animateSquare(with location: CGPoint) {
        animator.removeAllBehaviors()
        
        let attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: location)
        attachmentBehavior.length = 0
        attachmentBehavior.damping = 0.8
        attachmentBehavior.frequency = 1
        animator.addBehavior(attachmentBehavior)
        
        let snapBehavior = UISnapBehavior(item: squareView, snapTo: location)
        animator.addBehavior(snapBehavior)
    }
}
