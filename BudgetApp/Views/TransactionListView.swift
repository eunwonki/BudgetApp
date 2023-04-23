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

    init(request: NSFetchRequest<Transaction>) {
        _transactions = FetchRequest(fetchRequest: request)
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
