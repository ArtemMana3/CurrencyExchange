//
//  AddTransaction-ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 10.12.2022.
//

import Foundation

class AddTransactionViewModel: ObservableObject {
    @Published var amount: Double?
    @Published var comment = ""
    @Published var account: CurrencyAccount = CurrencyAccount()
    
}
