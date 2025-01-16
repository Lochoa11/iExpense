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
            List {
                Section("Personal costs") {
                    ForEach(personalExpenses) { item in
                        HStack {
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            AmountView(amount: item.amount)
                        }
                    }
//                    .onDelete { offsets in
//                        removeItems(at: offsets, type: "Personal")
//                    }
                }
                
                Section("Business costs") {
                    ForEach(businessExpenses) { item in
                        HStack {
                            Text(item.name)
                                .font(.headline)
                            Spacer()
                            AmountView(amount: item.amount)
                        }
                    }
//                    .onDelete { offsets in
//                        removeItems(at: offsets, type: "Business")
//                    }
                }
        
            }
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
    
//    func removeItems(at offsets: IndexSet, type: String) {
//       
//        // Get filtered items of the specified type
//        let filteredItems = expenses.items.filter { $0.type == type }
//        
//        // Convert offsets to indices in the filtered array
//        let indexToRemove = filteredItems[offsets.first!]
//       
//       // Remove items from the original array
//        if let indexInOriginalArray = expenses.items.firstIndex(where: { $0.id == indexToRemove.id }) {
//            expenses.items.remove(at: indexInOriginalArray)
//        }
//    }
}

#Preview {
    ContentView()
}
