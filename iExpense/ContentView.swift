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
    
    @State private var showingPersonalExpenses = true
    
    var body: some View {
        NavigationStack {
            ExpensesList(sortOrder: sortOrder, showingPersonalExpenses: showingPersonalExpenses)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add Expense", systemImage: "plus")
                    }
                    Button(showingPersonalExpenses ? "Business Expenses" : "Personal Expenses") {
                        showingPersonalExpenses.toggle()
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
                }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
