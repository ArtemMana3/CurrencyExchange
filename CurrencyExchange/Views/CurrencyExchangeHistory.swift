//
//  CurrencyExchangeHistory.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

struct CurrencyExchangeHistory: View {
    @StateObject var dc = DataController()
    var vm = ViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(dc.transactions) { transaction in
                    HStack(alignment: .center) {
                        Text("\(transaction.quantity)\(transaction.yourCurrency?.getSymbol() ?? "$")")
                            .frame(minWidth: 90, alignment: .leading)

                        Spacer()
                        VStack() {
                            Image(systemName: "arrow.right.circle")
                            Text("rate: \(vm.getRate(transaction))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()

                        Text("\(transaction.quantityPurchased)\(transaction.currencyPurchased?.getSymbol() ?? "$")")
                            .frame(minWidth: 90, alignment: .trailing)
                    }
                    
                }
                .onDelete(perform: dc.deleteTransaction)
            }
            .navigationTitle("History")
            .toolbar {
                NavigationLink {
                    AddTransaction(dc: dc)
                } label: {
                    Label("Plus", systemImage: "plus")
                }
            }
        }
        
    }
}

struct CurrencyExchangeHistory_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeHistory()
    }
}
