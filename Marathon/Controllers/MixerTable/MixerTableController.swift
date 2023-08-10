//
//  MixerTableController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

final class MixerTableController: UIViewController {
    
    // MARK: - Properties
    
    private static let cellIdentifier = "UITableViewCell"
    
    private var dataList: [String] = Array(0...30).map { String($0) }
    
    private var selected = [String]()
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, String> = {
        UITableViewDiffableDataSource<String, String>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier)
            
            cell?.textLabel?.text = itemIdentifier
            cell?.accessoryType = self.selected.contains(itemIdentifier) ? .checkmark : .none
            
            return cell
        }
    }()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        
        table.layer.cornerRadius = 8
        
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
        
        updateData(dataList)
    }
    
    // MARK: - Setup Views
    
    private func setupNavigation() {
        title = "Task 4"
        
        navigationItem.rightBarButtonItem = .init(
            title: "Shuffle",
            primaryAction: .init(handler: { [weak self] _ in self?.shuffle() })
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    
    private func updateData(_ dataList: [String], animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        
        snapshot.appendSections(["first"])
        snapshot.appendItems(dataList, toSection: "first")
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    @objc
    private func shuffle() {
        updateData(dataList.shuffled(), animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MixerTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if selected.contains(item) {
            selected = selected.filter { $0 != item }
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            return
        } else {
            selected.append(item)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        guard let first = dataSource.snapshot().itemIdentifiers.first,
              first != item else { return }
        
        var snapshot = dataSource.snapshot()
        snapshot.moveItem(item, beforeItem: first)
        dataSource.apply(snapshot)
    }
}
