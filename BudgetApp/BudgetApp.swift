//
//  BudgetApp.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import SwiftUI

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
