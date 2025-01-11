//
//  AmountView.swift
//  iExpense
//
//  Created by Lin Ochoa on 1/10/25.
//

import SwiftUI

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
