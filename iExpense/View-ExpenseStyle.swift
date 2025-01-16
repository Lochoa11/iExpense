//
//  View-ExpenseStyle.swift
//  iExpense
//
//  Created by Lin Ochoa on 1/16/25.
//

import SwiftUI

extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
    
    func changeColor(for amount: Double) -> some View {
        if amount < 10.00 {
            return self.foregroundStyle(.green)
        } else if amount < 100.00 {
            return self.foregroundStyle(.yellow)
        } else {
            return self.foregroundStyle(.red)
        }
    }
}
