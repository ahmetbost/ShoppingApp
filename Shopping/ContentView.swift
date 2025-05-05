//
//  ContentView.swift
//  Shopping
//
//  Created by Ahmet Bostancıoğlu on 2.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddItemView = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    @StateObject private var viewModel = ShoppingListViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                        ForEach(viewModel.shoppingList) { item in
                            ZStack(alignment: .leading) {
                                Button {
                                    viewModel.toggleIsBought(for: item)
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(item.isBought ? Color.red.gradient : Color.green.gradient)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("\(item.amount ?? 1)")
                                        .font(.caption2)
                                    Text(item.name)
                                    Spacer()
                                    Text("\(item.category.emoji) \(item.category.rawValue)")
                                        .font(.caption)
                                }
                                .padding()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .contextMenu {
                                Button(role: .destructive) {
                                    withAnimation {
                                        viewModel.delete(item: item)
                                    }
                                }label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .navigationTitle("Shopping List")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .tabItem {
                Label("List", systemImage: "cart")
            }
            
            NavigationStack {
                AddItemView()
            }
            .tabItem {
                    Label("Add", systemImage: "plus")
                }
                .environmentObject(viewModel)
                
                NavigationStack {
                    BoughtItemsView()
                }
                .tabItem {
                    Label("Bought Items", systemImage: "checkmark")
                }
            }
            .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
