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
        
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        squareView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}