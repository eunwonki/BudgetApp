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
    let onEditBudgetCategory: (BudgetCategory) -> Void

    var body: some View {
        List(budgetCategoryResults) { budgetCategory in

            if !budgetCategoryResults.isEmpty {
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber,
                                     formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overspent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overspent ? .red : .green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onLongPressGesture {
                            onEditBudgetCategory(budgetCategory)
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
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgetcategory in
            BudgetDetailView(budgetCategory: budgetcategory)
        }
    }
}

// struct BudgetListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetListView()
//    }
// }
