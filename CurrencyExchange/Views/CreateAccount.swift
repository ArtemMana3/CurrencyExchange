//
//  CreateAccount.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import SwiftUI

struct CreateAccount: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var quantityIsFocused: Bool
    
    @StateObject var vm = AddAccountViewModel()
    
    var body: some View {
        Form {
            Section("Add account") {
                TextField("Name", text: $vm.name)

                Button("\(vm.currency.getFlag()) \(vm.currency)") {
                    vm.currencySheet = true
                    quantityIsFocused = false
                }
            
                TextField("Initial amount", value: $vm.amount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($quantityIsFocused)
            }
            
            Section("Save") {
                Button("Save") {
                    let account = CurrencyAccount()
                    account.currency = vm.currency
                    account.name = vm.name
                    account.amount = vm.amount ?? 0.0
                    account.save()
                    dismiss()
                    quantityIsFocused = false
                }
            }
        }
        .navigationTitle("Add account")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $vm.currencySheet) {
            ChooseCurrency(chosenCurrency: $vm.currency)
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
