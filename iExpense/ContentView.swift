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
                NavigationLink("Add expense") {
                    AddView(expenses: expenses)
                }            
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

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct AmountView: View {
    var amount: Double
    var bold: Bool {
        switch amount {
        case 0..<10:    return false
        case 10..<100:  return false
        case 100...:    return true
        default:        return false
        }
    }
    var ital: Bool {
        switch amount {
        case 0..<10:    return true
        case 10..<100:  return false
        case 100...:    return false
        default:        return false
        }
    }
    var color: Color {
        switch amount {
        case 0..<10:    return Color.green
        case 10..<100:  return Color.orange
        case 100...:    return Color.red
        default:        return Color.primary
        }
    }
    
    var body: some View {
        Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .foregroundStyle(color)
            .italic(ital)
            .bold(bold)
    }
}

#Preview {
    ContentView()
}
