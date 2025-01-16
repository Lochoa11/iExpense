//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Lin Ochoa on 1/10/25.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
