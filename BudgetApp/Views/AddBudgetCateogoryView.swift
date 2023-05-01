//
//  AddBudgetCateogoryView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import SwiftUI

struct AddBudgetCateogoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var title: String = ""
    @State var total: Double = 100
    @State var messages: [String] = []
    
    private var budgetCategory: BudgetCategory?
    
    init(budgetCategory: BudgetCategory? = nil) {
        self.budgetCategory = budgetCategory
    }
    
    var isFormValid: Bool {
        messages.removeAll()
        
        if title.isEmpty {
            messages.append("Title is required")
        }
        
        if total <= 0 {
            messages.append("Total should ve greater than 1")
        }
        
        return messages.count == 0
    }
    
    private func addOrUpdate() {
        
        if let budgetCategory {
            let budget = BudgetCategory.byId(budgetCategory.objectID)
            budget.title = title
            budget.total = total
        } else {
            let budgetCategory = BudgetCategory(context: viewContext)
            budgetCategory.title = title
            budgetCategory.total = total
        }
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                Slider(value: $total, in: 0 ... 500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$0")
                } maximumValueLabel: {
                    Text("$500")
                }
                
                Text(total as NSNumber,
                     formatter: NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
                
            }
            
            .onAppear {
                if let budgetCategory {
                    title = budgetCategory.title ?? ""
                    total = budgetCategory.total
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            addOrUpdate()
                        }
                    }
                }
            }
        }
    }
}

struct AddBudgetCateogoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetCateogoryView()
    }
}
