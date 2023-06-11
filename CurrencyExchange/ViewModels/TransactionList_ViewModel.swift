//
//  TransactionList_ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 04.06.2023.
//

import Foundation
import RealmSwift

class TransactionListViewModel: ObservableObject {
    @Published var showAlert = false
    @ObservedResults(TransactionCurrency.self) var transactions
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
