//
//  ExpensesList.swift
//  iExpense
//
//  Created by Lin Ochoa on 1/16/25.
//

import SwiftData
import SwiftUI

struct ExpensesList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [ExpenseItem]
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: localCurrency))
                        .style(for: item)
                        .changeColor(for: item.amount)
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], expensesListType: String) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { item in
            if expensesListType == "All" {
                return true
            } else if expensesListType == "Personal" {
                return item.type.contains("Personal")
            } else {
                return item.type.contains("Business")
            }
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesList(sortOrder: [SortDescriptor(\ExpenseItem.name)], expensesListType: "All")
        .modelContainer(for: ExpenseItem.self)
}
