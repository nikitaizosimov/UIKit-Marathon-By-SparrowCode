//
//  CaringCollectionController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class CaringCollectionController: UIViewController {
    
    // MARK: - Properties
    
    private let project: Project
    
    private static let itemSize: CGSize = .init(width: 300, height: 400)
    private static let itemSpacing: CGFloat = 16
    
    // MARK: - Views
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = Self.itemSize
        
        layout.minimumLineSpacing = Self.itemSpacing
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        view.showsHorizontalScrollIndicator = false
        
        view.dataSource = self
        view.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
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
        
        setupNavigation()
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigation() {
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Task",
            primaryAction: UIAction(handler: { [weak self] _ in self?.openTaskPopover() })
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionViewLayout.sectionInset.left = collectionView.layoutMargins.left
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

// MARK: - UICollectionViewDataSource

extension CaringCollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 12 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        cell.contentView.backgroundColor = .lightGray
        cell.contentView.layer.cornerRadius = 12
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CaringCollectionController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let itemWidth = Self.itemSize.width + Self.itemSpacing
        let contentOffset = targetContentOffset.pointee.x + Self.itemSpacing
        let itemToScroll = round(contentOffset / itemWidth)
        
        targetContentOffset.pointee = CGPoint(x: itemToScroll * itemWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension CaringCollectionController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle { .none }
}
