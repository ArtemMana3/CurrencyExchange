//
//  CurrencyExchangeHistory-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 08.12.2022.
//

import Foundation
import SwiftUI

extension CurrencyExchangeHistory {
    class ViewModel {
        func getRate(_ transaction: Transaction) -> String {
            let quantityPurchased = Double(transaction.quantityPurchased == 0 ? 1 : transaction.quantityPurchased)
            // Divide by zero is not allowed
            let quantity = Double(transaction.quantity == 0 ? 1 : transaction.quantity)
            let rate = quantityPurchased / quantity
            return String(round(rate * 1000)/1000)
        }
    }
}
