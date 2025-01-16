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
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesList()
        .modelContainer(for: ExpenseItem.self)
}
