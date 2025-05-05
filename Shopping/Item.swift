//
//  Item.swift
//  Shopping
//
//  Created by Ahmet Bostancıoğlu on 2.05.2025.
//

import SwiftUI

enum Category: String, CaseIterable, Codable {
    
    case dairy = "Dairy Product"
    case meat = "Meat"
    case vegetable = "Vegetable"
    case fruit = "Fruit"
    case bakery = "Bakery"
    case snack = "Snack"
    case beverage = "Beverage"
    
    var emoji: String {
        switch self {
        case .dairy: "🥛"
        case .meat: "🥩"
        case .vegetable: "🥦"
        case .fruit: "🍎"
        case .bakery: "🍞"
        case .snack: "🍫"
        case .beverage: "🥤"
        }
    }
}

struct Item: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var amount: Int?
    var category: Category
    var isBought: Bool

    init(id: UUID = UUID(), name: String, amount: Int? = nil, category: Category, isBought: Bool) {
        self.id = id
        self.name = name
        self.amount = amount
        self.category = category
        self.isBought = isBought
    }
}
