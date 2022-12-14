//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CurrencyRate()
                .tabItem {
                    Label("Rate", systemImage: "dollarsign.circle.fill")
                }
            CurrencyExchange()
                .tabItem {
                    Label("Exchange", systemImage: "globe.europe.africa.fill")
                }
            CurrencyExchangeHistory()
                .tabItem {
                    Label("History", systemImage: "bag.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
