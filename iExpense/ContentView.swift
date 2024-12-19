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
                    .onDelete(perform: removeItems)
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
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
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
