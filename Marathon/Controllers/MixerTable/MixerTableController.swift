//
//  MixerTableController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

enum DataSource {
    
    static let items: [Item] = Array(0...30).map { Item(text: String($0)) }
}

struct Item {
    
    let text: String
    private(set) var isSelected: Bool = false
    
    mutating func toggleSelect() {
        isSelected.toggle()
    }
}

final class MixerTableController: UIViewController {
    
    // MARK: - Properties
    
    private static let cellIdentifier = "UITableViewCell"
    
    private var itemsList = DataSource.items
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.backgroundColor = .white
        table.layer.cornerRadius = 8
        
        table.dataSource = self
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
    }
    
    // MARK: - Setup Views
    
    private func setupNavigation() {
        title = "Task 4"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Shuffle",
            style: .plain,
            target: self,
            action: #selector(shuffle)
        )
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc
    func shuffle() {
        itemsList.shuffle()
        
        tableView.beginUpdates()
        itemsList.indices.forEach { tableView.reloadRows(at: [IndexPath(row: $0, section: 0)], with: .bottom) }
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource

extension MixerTableController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        
        let item = itemsList[indexPath.row]
        
        cell.textLabel?.text = item.text
        cell.accessoryType = item.isSelected ? .checkmark : .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MixerTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        itemsList[indexPath.row].toggleSelect()
        
        guard itemsList[indexPath.row].isSelected else {
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return
        }
        
        cell.accessoryType = .checkmark
        
        let item = itemsList[indexPath.row]
        itemsList.remove(at: indexPath.row)
        itemsList.insert(item, at: 0)
        
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
    }
}