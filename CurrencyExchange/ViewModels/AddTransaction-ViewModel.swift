//
//  AddTransaction-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 10.12.2022.
//

import Foundation

class AddTransactionViewModel: ObservableObject {
    @Published var yourCurrency = "USD"
    @Published var quantity = 0
    
    @Published var currencyPurchased = "EUR"
    @Published var quantityPurchased = 0
}
