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
    
    private var itemsList: [Item] = Array(0...30).map { Item(text: String($0)) }
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, Item> = {
        UITableViewDiffableDataSource<String, Item>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
            
            cell.textLabel?.text = item.text
            cell.accessoryType = item.isSelected ? .checkmark : .none
            
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
        
        updateData(itemsList)
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
    
    private func updateData(_ itemList: [Item], animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
        
        snapshot.appendSections(["first"])
        snapshot.appendItems(itemList, toSection: "first")
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    @objc
    private func shuffle() {
        itemsList.shuffle()
        updateData(itemsList, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MixerTableController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        guard let cell = tableView.cellForRow(at: indexPath) else { return }
//
//        itemsList[indexPath.row].toggleSelect()
//
//        guard itemsList[indexPath.row].isSelected else {
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//            return
//        }
//
//        cell.accessoryType = .checkmark
//
//        let item = itemsList[indexPath.row]
//        itemsList.remove(at: indexPath.row)
//        itemsList.insert(item, at: 0)
//
//        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
    }
}
