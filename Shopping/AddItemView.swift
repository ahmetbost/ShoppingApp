//
//  AddItemView.swift
//  Shopping
//
//  Created by Ahmet Bostancıoğlu on 2.05.2025.
//

import SwiftUI

let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    formatter.zeroSymbol  = ""
    return formatter
}()

struct AddItemView: View {
    
    @State private var showingAlert = false
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    @State private var itemName = String()
    @State private var itemCategory = Category.dairy
    @State private var amount: Int?
    @State private var isBoughtSwitch = false
    
    @State private var alertText = "Product name not specified"
    @State private var alertMessage = "You should name the product."
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        TextField("#", value: $amount, formatter: numberFormatter)
                            .frame(width: 25)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        TextField("Product Name", text: $itemName)
                            .focused($isFocused)
                    }
                    
                    Picker("Category", selection: $itemCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text("\(category.emoji) \(category.rawValue)").tag(category)
                        }
                    }
                }
                
                Spacer()
                
                Button("Add") {
                    guard !itemName.isEmpty else {
                        alertText = "Product name not specified"
                        alertMessage = "You should name the product."
                        return showingAlert = true
                    }
                    
                    let newItem = Item(name: itemName, amount: amount ?? 1, category: itemCategory, isBought: false)
                    viewModel.shoppingList.append(newItem)
                    alertText = "Completed"
                    alertMessage = "Product is added to your list."
                    showingAlert = true
                    itemName = ""
                    amount = nil
                    isFocused = false
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertText), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddItemView()
        .environmentObject(ShoppingListViewModel())
}
