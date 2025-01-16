//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Lin Ochoa on 12/5/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
