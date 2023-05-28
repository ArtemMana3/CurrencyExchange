//
//  CurrencySavings.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import SwiftUI
import RealmSwift

struct CurrencySavings: View {
    @ObservedResults(CurrencyAccount.self) var accounts

    var body: some View {
        NavigationView {
            ZStack {
                Color("primary").edgesIgnoringSafeArea(.all)
                ScrollView {
                    ForEach (accounts) { account in
                        NavigationLink {
                            TransactionList(account: account)
                        } label: {
                            VStack(spacing: 16) {
                                Text("Account: \(account.name)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("main"))
                                    .bold()

                                Text("TOTAL BALANCE")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .bold()

                                Text("\(account.currency.getSymbol() ?? "$")\(String(round(account.amount * 100)/100))")
                                    .font(.system(size: 30))
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                            .background(Color("secondary"))
                            .cornerRadius(8)
                            .padding(10)
                        }
                    }
                    
                    NavigationLink {
                        CreateAccount()
                    } label: {
                        VStack(spacing: 16) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.blue)
                            
                            Text("ADD ACCOUNT")
                                .font(.system(.caption, design: .rounded))
                                .bold()
                                .foregroundColor(Color.blue)
                        }
                        .frame(minWidth: 200, maxWidth: 250, minHeight: 100, maxHeight: 100)
                        .background(Color("secondary"))
                        .cornerRadius(8)
                        .padding(5)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: NavigationLazyView(AddTransaction()),
                                       label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 55.0, height: 55.0)
                            
                        })
                    }
                }.padding(12)
            }
            .navigationTitle("Save")
            
        }
    }
    
}

struct CurrencySavings_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySavings()
    }
}

// Lazy Navigation to load (constructor) after clicked on Button
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) { self.build = build }
    var body: Content { build() }
}
