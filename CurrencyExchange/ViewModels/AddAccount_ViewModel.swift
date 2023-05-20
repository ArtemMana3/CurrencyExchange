//
//  AddCurrencyAccount_ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    @Published var name = ""
    @Published var currency = "USD"
    @Published var amount: Double?
    @Published var currencySheet = false
}
