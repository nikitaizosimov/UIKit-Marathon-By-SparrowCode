//
//  StretchingPictureController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class StretchingPictureController: UIViewController {
    
    // MARK: - Properties
    
    private static var defaultImageHeight: CGFloat = 270
    
    private var contentViewTopConstraint: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.delegate = self
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        view.automaticallyAdjustsScrollIndicatorInsets = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = #imageLiteral(resourceName: "flower")
        view.contentMode = .scaleAspectFill
        
        imageViewHeightConstraint = view.heightAnchor.constraint(equalToConstant: Self.defaultImageHeight)
        imageViewHeightConstraint?.isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.masksToBounds = true
        
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        contentViewTopConstraint?.isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height).isActive = true
        
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}

// MARK: - UIScrollViewDelegate

extension StretchingPictureController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY < 0 {
            contentViewTopConstraint?.constant = contentOffsetY
            imageViewHeightConstraint?.constant = Self.defaultImageHeight - view.safeAreaInsets.top + abs(contentOffsetY)
        }
        
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(
            top: imageViewHeightConstraint?.constant ?? 0,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
}
