//
//  TaskPopoverController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class TaskPopoverController: UIViewController {
    
    // MARK: -  Views
    
    private lazy var textTitle: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    // MARK: -  Init
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        
        textTitle.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: -  Setup Views
    
    private func setupViews() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(textTitle)
        textTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        textTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        view.addSubview(buttonImage)
        buttonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        buttonImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    }
}
