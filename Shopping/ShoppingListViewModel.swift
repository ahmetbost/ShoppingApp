//
//  ShoppingListViewModal.swift
//  Shopping
//
//  Created by Ahmet Bostancıoğlu on 2.05.2025.
//

import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [Item] = [] {
        didSet {
            saveItems()
        }
    }
    
    init() {
        loadItems()
        
    }
    
    private let saveKey = "ShoppingListData"
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(shoppingList) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            let decoded = try? JSONDecoder().decode([Item].self, from: data)
            shoppingList = decoded ?? []
        }
    }
    
    func toggleIsBought(for item: Item) {
        withAnimation {
            if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
                shoppingList[index].isBought.toggle()
                
            }
        }
    }
    
    func delete(item: Item) {
        withAnimation {
            if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
                shoppingList.remove(at: index)
            }
        }
    }
    
    
}
