//
//  AddTransaction.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 13.11.2022.
//

import SwiftUI

struct AddTransaction: View, FlagOrSymbol {
    @Environment(\.dismiss) var dismiss
    
    @State private var yourCurrency = "USD"
    @State private var quantity = 0

    @State private var currencyPurchased = "EUR"
    @State private var quantityPurchased = 0
        
    @State private var yourCurrencySheet = false
    @State private var wannaCurrencySheet = false
    
    @ObservedObject var dc: DataController

    var body: some View {
        Form {
            Section("Your currency and quantity") {
                Button("\(getFlag(currency: yourCurrency)) \(yourCurrency)") {
                    yourCurrencySheet = true
                }
                TextField("Quantity", value: $quantity, format: .number)
            }
            
            Section("What did you buy") {
                Button("\(getFlag(currency: currencyPurchased)) \(currencyPurchased)") {
                    wannaCurrencySheet = true
                }
                TextField("Quantity", value: $quantityPurchased, format: .number)
            }
            Section {
                Button("Save") {
                    dc.addTransaction(quantity: quantity,
                                      yourCurrency: yourCurrency,
                                      quantityPurchased: quantityPurchased,
                                      currencyPurchased: currencyPurchased)
                    dismiss()
                }
                
            }
            .navigationTitle("Add transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $yourCurrencySheet) {
            ChooseCurrency(chosenCurrency: $yourCurrency)
        }
        .sheet(isPresented: $wannaCurrencySheet) {
            ChooseCurrency(chosenCurrency: $currencyPurchased)
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTransaction(dc: DataController())
    }
}
