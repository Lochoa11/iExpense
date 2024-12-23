//
//  AddView.swift
//  iExpense
//
//  Created by Lin Ochoa on 12/10/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = "Item Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                }
            }
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
                .disabled(name.isEmpty || amount == 0)
            }
            .navigationBarBackButtonHidden(true)
            
            Text("Add Expense")
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
