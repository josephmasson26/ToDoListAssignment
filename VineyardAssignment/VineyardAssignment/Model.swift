//
//  Model.swift
//  VineyardAssignment
//
//  Created by Rahul on 9/5/24.
//

import SwiftUI

@Observable
class ItemList: Identifiable {
    var id: UUID = .init()
    var name: String
    var items: [Item] = []
    // Done: What properties would ItemList have?
    
    init(name: String) {
        self.name = name
    }
    
    struct Item: Identifiable {
        // Donne: What properties would Item have?
        var id: UUID = .init()
        var name: String
        var isCompleted: Bool = false

        init(name: String) {
            self.name = name
        }
    }
    
    func addItem(_ name: String) {
        // Done: Create an Item object with the given name, and add it to this ItemList.
        let newItem = Item(name: name)
        items.append(newItem)
    }
    
    func toggleItemAsCompleted(_ item: Item) {
        // Done: Toggle the given Item as complete/incomplete in this ItemList.
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}

