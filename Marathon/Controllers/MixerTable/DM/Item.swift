//
//  Item.swift
//  Marathon
//
//  Created by Nikita Izosimov on 12.08.2023.
//

import Foundation

struct Item: Hashable {
    
    let id = UUID()
    let text: String
    private(set) var isSelected: Bool = false
    
    mutating func toggleSelect() {
        isSelected.toggle()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.text)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
