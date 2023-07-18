//
//  NativeAvatarController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class NativeAvatarController: UIViewController {
    
    // MARK: - Views
    
    private lazy var avatarContainerView: UIView = { UIView() }()
    
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "person.crop.circle.fill")
        
        view.tintColor = .systemGray
        
        view.widthAnchor.constraint(equalToConstant: 36).isActive = true
        view.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupNativeAvatar()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigation() {
        title = "Avatar"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNativeAvatar() {
        guard let view = navigationController?.navigationBar
            .subviews
            .first(where: { $0.description.contains("UINavigationBarLargeTitleView") }) else { return }
        
        view.addSubview(avatarView)
        avatarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
