//
//  CurrencyExchangeHistory.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

struct CurrencyExchangeHistory: View {
    @StateObject var vm = CurrencyExchangeHistoryViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.transactions) { transaction in
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
                .onDelete(perform: vm.deleteTransaction)
            }
            .navigationTitle("History")
            .toolbar {
                NavigationLink {
                    AddTransaction(superVM: vm)
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
