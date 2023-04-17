//
//  BudgetCategory+CoreData.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
}
