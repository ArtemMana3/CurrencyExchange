//
//  CurrencyRate-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import Foundation

extension CurrencyRate {    
    @MainActor class ViewModel: ObservableObject, FlagOrSymbol {
        @Published var exchangeRates = [String: Double]()
        @Published var base = "USD"
                
        var necessaryCurrencies: [String] {
            return Currency.necessaryCurrencies.filter { currency in
                currency != base
            }
        }
        
        func loadData(base: String) async {
            self.base = base
            let exchangeRatesService = ExchangeRatesService()
            await exchangeRatesService.loadData(base: base)
            exchangeRates = exchangeRatesService.exchangeRates
        }
    }
}
