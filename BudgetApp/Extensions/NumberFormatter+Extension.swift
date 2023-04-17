//
//  NumberFormatter+Extension.swift
//  BudgetApp
//
//  Created by wonki on 2023/04/17.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
}
