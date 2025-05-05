//
//  BoughtItemsView.swift
//  Shopping
//
//  Created by Ahmet Bostancıoğlu on 3.05.2025.
//

import SwiftUI

struct BoughtItemsView: View {
    
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    let columns = [ GridItem(.adaptive(minimum: 120)) ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(viewModel.shoppingList.filter {
                        $0.isBought
                    }) { item in
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
            .navigationTitle("Bought Items")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        BoughtItemsView()
            .environmentObject(ShoppingListViewModel())
    }
}
