//
//  ChooseCurrency.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 14.11.2022.
//

import SwiftUI

struct ChooseCurrency: View, FlagOrSymbol {
    @Binding var chosenCurrency: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(Currency.necessaryCurrencies, id: \.self) { necessaryCurrency in
                        Button() {
                            chosenCurrency = necessaryCurrency
                            dismiss()
                        } label: {
                            Text("\(getFlag(currency: necessaryCurrency)) \(necessaryCurrency)")
                                .foregroundColor(.black)
                        }
                    }
                } header: {
                    Text("Select currency")
                }
            }
            .navigationBarItems(trailing: Button("Done", action: { dismiss() }))
            .navigationTitle("currencies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

