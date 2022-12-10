//
//  AddTransaction.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 13.11.2022.
//

import SwiftUI

struct AddTransaction: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var quantityIsFocused: Bool
    
    @ObservedObject var superVM: CurrencyExchangeHistoryViewModel
    @StateObject var vm = AddTransactionViewModel()
    
    var body: some View {
        Form {
            Section("Your currency and quantity") {
                Button("\(vm.yourCurrency.getFlag()) \(vm.yourCurrency)") {
                    vm.yourCurrencySheet = true
                    quantityIsFocused = false
                }
                TextField("Quantity", value: $vm.quantity, format: .number)
                    .keyboardType(.numberPad)
                    .focused($quantityIsFocused)

            }
            
            Section("What did you buy") {
                Button("\(vm.currencyPurchased.getFlag()) \(vm.currencyPurchased)") {
                    vm.wannaCurrencySheet = true
                    quantityIsFocused = false
                }
                TextField("Quantity", value: $vm.quantityPurchased, format: .number)
                    .keyboardType(.numberPad)
                    .focused($quantityIsFocused)
            }
            Section {
                Button("Save") {
                    superVM.addTransaction(quantity: vm.quantity,
                                   yourCurrency: vm.yourCurrency,
                                   quantityPurchased: vm.quantityPurchased,
                                   currencyPurchased: vm.currencyPurchased)
                    dismiss()
                    quantityIsFocused = false
                }
            }
        }
        .navigationTitle("Add transaction")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $vm.yourCurrencySheet) {
            ChooseCurrency(chosenCurrency: $vm.yourCurrency)
        }
        .sheet(isPresented: $vm.wannaCurrencySheet) {
            ChooseCurrency(chosenCurrency: $vm.currencyPurchased)
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTransaction(superVM: CurrencyExchangeHistoryViewModel())
    }
}
