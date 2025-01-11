//
//  ContentView.swift
//  iExpense
//
//  Created by Lin Ochoa on 12/5/24.
//

import Observation
import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    @State private var isPersonal = false
    @State private var isBusiness = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal costs") {
                    ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            AmountView(amount: item.amount)
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, type: "Personal")
                    }
                }
                
                Section("Business costs") {
                    ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                        HStack {
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            AmountView(amount: item.amount)
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, type: "Business")
                    }
                }
        
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, type: String) {
       
        // Get filtered items of the specified type
        let filteredItems = expenses.items.filter { $0.type == type }
        
        // Convert offsets to indices in the filtered array
        let indexToRemove = filteredItems[offsets.first!]
       
       // Remove items from the original array
        if let indexInOriginalArray = expenses.items.firstIndex(where: { $0.id == indexToRemove.id }) {
            expenses.items.remove(at: indexInOriginalArray)
        }
    }
}

#Preview {
    ContentView()
}
