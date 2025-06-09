//
//  Currency.swift
//  IncomeApp
//
//  Created by Irsal Hamdi on 09/06/25.
//

import Foundation

enum Currency : Int, CaseIterable {
    case usd, idr
    
    var title: String {
        switch self {
        case .usd:
            return "USD"
        case .idr:
            return "IDR"
        }
    }
    
    var locale: Locale {
        switch self {
        case .usd:
            return Locale(identifier: "en_US")
        case .idr:
            return Locale(identifier: "id_ID")
        }
    }
}
