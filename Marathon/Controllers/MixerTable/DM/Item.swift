//
//  Item.swift
//  Marathon
//
//  Created by Nikita Izosimov on 12.08.2023.
//

import Foundation

struct Item: Hashable {
    
    let id: String = UUID().uuidString
    let text: String
    private(set) var isSelected: Bool = false
    
    mutating func toggleSelect() {
        isSelected.toggle()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.text)
        hasher.combine(self.isSelected)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.text == rhs.text &&
        lhs.isSelected == rhs.isSelected
    }
}
