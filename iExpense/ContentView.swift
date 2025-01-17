//
//  ContentView.swift
//  iExpense
//
//  Created by Lin Ochoa on 12/5/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddExpense = false
    
    @State private var isPersonal = false
    @State private var isBusiness = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var expensesListType = "Personal"
    
    var body: some View {
        NavigationStack {
            ExpensesList(sortOrder: sortOrder, expensesListType: expensesListType)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add Expense", systemImage: "plus")
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort By", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Name (Z-A)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name, order: .reverse),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Amount(Cheapest First)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                            Text("Amount (Most Expensive First)")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $expensesListType) {
                            Text("Show All Expenses")
                                .tag("All")
                            
                            ForEach(AddView.types, id: \.self) { type in
                                Text(type)
                                    .tag(type)
                            }
                        }
                    }
                }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
