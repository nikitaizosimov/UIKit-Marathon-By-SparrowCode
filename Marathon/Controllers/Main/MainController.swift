//
//  MainController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 05.08.2023.
//

import UIKit

// 37

class MainController: UICollectionViewController {
    
    // MARK: - Properties
    
    typealias Project = (name: String, controller: UIViewController)
    
    let projects: [String] = ["1 ", "2", "3", "4", "5", "6", "7", "8", "9"]
    
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
        projects.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath)
        
        guard let cell = reusableCell as? MainCollectionCell else {
            return reusableCell
        }
        
        cell.textLabel.text = projects[indexPath.row]
        
        return cell
    }
}
