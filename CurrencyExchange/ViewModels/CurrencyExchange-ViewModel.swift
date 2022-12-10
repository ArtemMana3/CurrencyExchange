//
//  CurrencyExchange-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 08.12.2022.
//

import Foundation

extension CurrencyExchange {
    @MainActor class ViewModel: ObservableObject {
        @Published var exchangeRates = [String: Double]()
                
        @Published var yourCurrency = "USD"
        @Published var amount = 100
        
        @Published var wannaCurrency = "EUR"
        @Published var result = 0.0

        
        func loadData() async {
            let exchangeRatesClass = ExchangeRatesService()
            await exchangeRatesClass.loadData(base: yourCurrency, amount: amount)
            exchangeRates = exchangeRatesClass.exchangeRates
            result = exchangeRates[wannaCurrency]  ?? 0
        }
    }
}
