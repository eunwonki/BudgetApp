//
//  ContentView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented: Bool = false
    
    var total: Double {
        budgetCategoryResults.reduce(0) {
            result, budgetCategory in
            result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(
                    budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory)
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetCateogoryView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    // TODO: dismiss가 preview crashed를 야기함.
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
