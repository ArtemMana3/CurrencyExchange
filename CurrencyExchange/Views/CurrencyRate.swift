//
//  CurrencyRate.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

struct CurrencyRate: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        NavigationView {
            List {
                Section {
                    if let rate = vm.exchangeRates[vm.base] {
                        HStack {
                            Text(vm.base.getFlag())
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(vm.base)
                                Text(String(round(rate * 1000)/1000))
                            }
                        }
                    }
                }
                ForEach(vm.necessaryCurrencies, id: \.self) { necessaryCurrency in
                    if let rate = vm.exchangeRates[necessaryCurrency] {
                        HStack {
                            Text(necessaryCurrency.getFlag())
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(necessaryCurrency)
                                Text(String(round(rate * 1000)/1000))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Rate")
            .toolbar {
                Menu {
                    ForEach(Currency.necessaryCurrencies, id: \.self) { necessaryCurrency in
                        Button(necessaryCurrency) {
                            Task {
                                await vm.loadData(base: necessaryCurrency)
                            }
                        }
                    }
                } label:  {
                    Text(vm.base)
                }
            }
        }
        .task {
            await vm.loadData(base: vm.base)
        }
    }
}

struct CurrencyRate_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRate()
    }
}
