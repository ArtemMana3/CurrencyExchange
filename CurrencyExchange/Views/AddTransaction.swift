//
//  AddTransaction.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 13.11.2022.
//

import SwiftUI

struct AddTransaction: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var yourCurrencySheet = false
    @State private var wannaCurrencySheet = false
    
    @ObservedObject var superVM: CurrencyExchangeHistoryViewModel
    @StateObject var vm = AddTransactionViewModel()
    
    var body: some View {
        Form {
            Section("Your currency and quantity") {
                Button("\(vm.yourCurrency.getFlag()) \(vm.yourCurrency)") {
                    yourCurrencySheet = true
                }
                TextField("Quantity", value: $vm.quantity, format: .number)
            }
            
            Section("What did you buy") {
                Button("\(vm.currencyPurchased.getFlag()) \(vm.currencyPurchased)") {
                    wannaCurrencySheet = true
                }
                TextField("Quantity", value: $vm.quantityPurchased, format: .number)
            }
            Section {
                Button("Save") {
                    superVM.addTransaction(quantity: vm.quantity,
                                   yourCurrency: vm.yourCurrency,
                                   quantityPurchased: vm.quantityPurchased,
                                   currencyPurchased: vm.currencyPurchased)
                    dismiss()
                }
                
            }
            .navigationTitle("Add transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $yourCurrencySheet) {
            ChooseCurrency(chosenCurrency: $vm.yourCurrency)
        }
        .sheet(isPresented: $wannaCurrencySheet) {
            ChooseCurrency(chosenCurrency: $vm.currencyPurchased)
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTransaction(superVM: CurrencyExchangeHistoryViewModel())
    }
}
