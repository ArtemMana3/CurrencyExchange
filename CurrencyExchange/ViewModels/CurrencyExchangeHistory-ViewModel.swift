//
//  CurrencyExchangeHistory-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 08.12.2022.
//

import Foundation
import SwiftUI

class CurrencyExchangeHistoryViewModel: ObservableObject {
    @Published var transactions = [Transaction]()
    
    init() { fetchTransaction() }
    
    func getRate(_ transaction: Transaction) -> String {
        let quantityPurchased = Double(transaction.quantityPurchased == 0 ? 1 : transaction.quantityPurchased)
        // Divide by zero is not allowed
        let quantity = Double(transaction.quantity == 0 ? 1 : transaction.quantity)
        let rate = quantityPurchased / quantity
        return String(round(rate * 1000)/1000)
    }
    
    func fetchTransaction() {
        transactions = DataController.shared.fetchTransaction()
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        DataController.shared.deleteTransaction(at: offsets)
        fetchTransaction()
    }
    
    func addTransaction(quantity: Int, yourCurrency: String, quantityPurchased: Int, currencyPurchased: String) {
        DataController.shared.addTransaction(quantity: quantity,
                                             yourCurrency: yourCurrency,
                                             quantityPurchased: quantityPurchased,
                                             currencyPurchased: currencyPurchased)
        fetchTransaction()
    }
    
}
