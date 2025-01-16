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
    
    @Query(filter: #Predicate<ExpenseItem> { expense in
        expense.type.contains("Personal")
    }) var personalExpenses: [ExpenseItem]
    
    @Query(filter: #Predicate<ExpenseItem> { expense in
        expense.type.contains("Business")
    }) var businessExpenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    
    @State private var isPersonal = false
    @State private var isBusiness = false
    
    var body: some View {
        NavigationStack {
            ExpensesList()
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add Expense", systemImage: "plus")
                    }
                }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
