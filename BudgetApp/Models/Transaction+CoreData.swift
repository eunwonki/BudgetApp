//
//  Transaction+CoreData.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/23.
//

import CoreData
import Foundation

@objc(Transaction)
public class Transaction: NSManagedObject {
    override public func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
