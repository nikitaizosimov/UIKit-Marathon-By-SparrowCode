//
//  CompactPopoverController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class CompactPopoverController: UIViewController {
    
    // MARK: -  Properties
    
    private var kind = Kind.medium
    
    // MARK: -  Views
    
    private lazy var segmentControlView: UISegmentedControl = {
        let view = UISegmentedControl(items: Kind.allCases.map { $0.title })
        
        view.selectedSegmentIndex = 0
        
        view.addAction(
            UIAction(handler: { [weak self] _ in self?.setupContent() }),
            for: .valueChanged
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var buttonImage: UIButton = {
        let button = UIButton(
            configuration: .plain(),
            primaryAction: UIAction(handler: { [weak self] _ in self?.dismiss(animated: true) })
        )
        
        button.configuration?.image = UIImage(systemName: "xmark.circle.fill")
        button.configuration?.imageColorTransformer = .grayscale
        
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // MARK: -  Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContent()
    }
    
    // MARK: -  Setup Views
    
    private func setupViews() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(segmentControlView)
        segmentControlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        segmentControlView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(buttonImage)
        buttonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        buttonImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    }
    
    // MARK: -  Setup Content
    
    private func setupContent() {
        guard let kind = Kind(rawValue: segmentControlView.selectedSegmentIndex) else { return }
        
        preferredContentSize = kind.size
    }
}

// MARK: - Kind

extension CompactPopoverController {
    
    enum Kind: Int, CaseIterable {
        
        case medium
        case small
        
        var title: String {
            switch self {
            case .medium:
                return "280pt"
            case .small:
                return "150pt"
            }
        }
        
        var size: CGSize {
            switch self {
            case .medium:
                return CGSize(width: 300, height: 280)
            case .small:
                return CGSize(width: 300, height: 150)
            }
        }
    }
}
