//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/23.
//

import CoreData
import SwiftUI

struct BudgetDetailView: View {
    @Environment(\.managedObjectContext) private var context
    let budgetCategory: BudgetCategory
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        let transaction = Transaction(context: context)
        transaction.title = title
        transaction.total = Double(total) ?? 100
        
        budgetCategory.addToTransactions(transaction)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Budget: ")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }
            }
            
            Form {
                Section {
                    TextField("Name", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        saveTransaction()
                    }
                    .disabled(!isFormValid)
                    Spacer()
                }
            }
            
            BudgetSummaryView(budgetCategory: budgetCategory)
            
            TransactionListView(
                request: BudgetCategory.transactionByCategoryRequest(
                    budgetCategory))
            
            Spacer()
        }.padding()
    }
}

// struct BudgetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetDetailView(budgetCategory: BudgetCategory())
//    }
// }
