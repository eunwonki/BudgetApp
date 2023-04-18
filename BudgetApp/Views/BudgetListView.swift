//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/18.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void

    var body: some View {
        List(budgetCategoryResults) { budgetCategory in

            if !budgetCategoryResults.isEmpty {
                ForEach(budgetCategoryResults) { budgetCategory in
                    HStack {
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack {
                            Text(budgetCategory.total as NSNumber,
                                 formatter: NumberFormatter.currency)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0] }.forEach(onDeleteBudgetCategory)
                }
            } else {
                Text("No budget categories exists.")
            }
        }
    }
}

// struct BudgetListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetListView()
//    }
// }
