//
//  BudgetSummaryView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/24.
//

import SwiftUI

struct BudgetSummaryView: View {
    @ObservedObject var budgetCategory: BudgetCategory

    var body: some View {
        VStack {
            Text("\(budgetCategory.overspent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overspent ? .red : .green)
        }
    }
}

// struct BudgetSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetSummaryView()
//    }
// }
