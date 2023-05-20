//
//  AddTransaction.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 13.11.2022.
//

import SwiftUI
import RealmSwift

struct AddTransaction: View {
    @Environment(\.dismiss) var dismiss

    @FocusState private var quantityIsFocused: Bool

    @StateObject var vm = AddTransactionViewModel()
    @ObservedResults(CurrencyAccount.self) var accounts: Results<CurrencyAccount>

    var body: some View {
        Form {
            Section("Add transaction") {
                TextField("Amount", value: $vm.amount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($quantityIsFocused)
                                
                Picker("Account", selection: $vm.account) {
                    ForEach(accounts, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }
                
                TextField("Comment", text: $vm.comment)
            }
            
            Section("Save") {
                Button("Save") {
                    let transaction = TransactionCurrency()
                    transaction.amount = vm.amount ?? 0.0
                    transaction.comment = vm.comment
                    transaction.accountId = vm.account._id.stringValue
                    transaction.save()
                    
                    vm.account.updateAmount(amount: vm.amount ?? 0.0)
        
                    dismiss()
                    quantityIsFocused = false
                }
            }
        }
        .navigationTitle("Add transaction")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !accounts.isEmpty {
                vm.account = accounts[0]
            }
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTransaction()
    }
}
