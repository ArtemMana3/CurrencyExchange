//
//  ExchangeRatesService.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 08.12.2022.
//

import Foundation

class ExchangeRatesService: ObservableObject {
    @Published var exchangeRates = [String: Double]()
    
    func loadData(base: String, amount: Int = 1) async {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(base)&amount=\(amount)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Currency.self, from: data) {
                self.exchangeRates = decodedResponse.rates
            }
        } catch {
            print("Invalid data")
        }
        
       
    }
}

