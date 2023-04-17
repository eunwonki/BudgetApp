//
//  CoreDataManager.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private var persitentContainer: NSPersistentContainer
    
    private init() {
        persitentContainer = NSPersistentContainer(name: "BudgetModel")
        persitentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persitentContainer.viewContext
    }
    
}
