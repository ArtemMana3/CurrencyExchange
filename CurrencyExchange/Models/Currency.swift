//
//  Currency.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import Foundation

struct Currency: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates: [String: Double]
    
    static let necessaryCurrencies = ["USD", "EUR", "PLN", "GBP", "TRY", "CZK", "DKK", "CAD", "CHF", "CNY", "JPY", "KRW"]
}
