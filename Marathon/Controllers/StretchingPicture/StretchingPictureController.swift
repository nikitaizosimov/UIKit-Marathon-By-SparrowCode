//
//  StretchingPictureController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class StretchingPictureController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
    private static var defaultImageHeight: CGFloat = 270
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.delegate = self
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = #imageLiteral(resourceName: "flower")
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        imageView.frame = .init(
            x: .zero,
            y: -scrollView.safeAreaInsets.top,
            width: scrollView.frame.width,
            height: Self.defaultImageHeight
        )
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Task",
            primaryAction: UIAction(handler: { [weak self] _ in self?.openTaskPopover() })
        )
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
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

// MARK: - UIScrollViewDelegate

extension StretchingPictureController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + scrollView.safeAreaInsets.top
        
        if y < 0 {
            imageView.frame = .init(x: .zero, y: -scrollView.safeAreaInsets.top + y, width: scrollView.frame.width, height: Self.defaultImageHeight + abs(y))
        }
        
        scrollView.verticalScrollIndicatorInsets.top = imageView.frame.height - scrollView.safeAreaInsets.top
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension StretchingPictureController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
