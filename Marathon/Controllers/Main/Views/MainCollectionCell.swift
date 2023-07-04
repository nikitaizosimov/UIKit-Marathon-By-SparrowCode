//
//  MainCollectionCell.swift
//  Marathon
//
//  Created by Nikita Izosimov on 05.08.2023.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    private(set) lazy var textLabel: UILabel = { UILabel() }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Common Init
    
    private func commonInit() {
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
