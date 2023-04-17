//
//  AddBudgetCateogoryView.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import SwiftUI

struct AddBudgetCateogoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var title: String = ""
    @State var total: Double = 100
    @State var messages: [String] = []
    
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
    
    private func save() {
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        // save the context
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
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
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {}
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            save()
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
