//
//  ContentView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import SwiftUI

enum SheetAction: Identifiable {
    case add
    case edit (BudgetCategory)
    
    var id: Int {
        return self.rawValue
    }
    
    var rawValue: Int {
        switch self {
        case .add: return 1
        case .edit: return 2
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    @State private var sheetAction: SheetAction?
    
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
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget: ")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                
                BudgetListView(
                    budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
            }
            .padding()
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }
        }
        
        .sheet(item: $sheetAction) { sheetAction in
            switch sheetAction {
            case .add:
                AddBudgetCateogoryView()
            case .edit(let budgetCategory):
                AddBudgetCateogoryView(budgetCategory: budgetCategory)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    // TODO: dismiss가 preview crashed를 야기함.
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
