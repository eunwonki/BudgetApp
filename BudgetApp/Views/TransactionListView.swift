//
//  TransactionListView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/23.
//

import CoreData
import SwiftUI

struct TransactionListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    let onDeleteTransaction: (Transaction) -> Void

    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }

    var body: some View {
        if transactions.isEmpty {
            Text("No transactions.")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }.onDelete { offsets in
                    offsets.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
            }
        }
    }
}

// struct TransactionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListView()
//    }
// }
