//
//  TransactionTypeModel.swift
//  IncomeApp
//
//  Created by Irsal Hamdi on 08/06/25.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable{
    case income, expense
    var id: Self { self }
    
    var title: String{
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
