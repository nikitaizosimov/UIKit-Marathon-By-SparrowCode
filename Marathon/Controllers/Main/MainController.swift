//
//  MainController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 05.08.2023.
//

import UIKit

// 31

final class MainController: UICollectionViewController {
    
    // MARK: - Properties
    
    let projectList = Project.allCases
    
    private lazy var section: NSCollectionLayoutSection = {
        let size: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
        
        return section
    }()
    
    // MARK: - Init
    
    init() { super.init(collectionViewLayout: UICollectionViewFlowLayout()) }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Проекты"
        
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "MainCollectionCell")
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        projectList.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath)
        
        guard let cell = reusableCell as? MainCollectionCell else {
            return reusableCell
        }
        
        cell.textLabel.text = projectList[indexPath.row].name
        
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let controller = projectList[indexPath.row].controller
        navigationController?.pushViewController(controller, animated: true)
    }
}
