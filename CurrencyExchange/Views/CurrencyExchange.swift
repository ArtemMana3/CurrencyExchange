//
//  CurrencyExchange.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

struct CurrencyExchange: View {
    @State private var yourCurrencySheet = false
    @State private var wannaCurrencySheet = false
    @FocusState private var amountIsFocused: Bool

    @StateObject var viewModel = CurrencyExchangeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("I have")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundColor(.gray)

                Button {
                    yourCurrencySheet = true
                } label: {
                    Text("\(viewModel.yourCurrency.getFlag()) \(viewModel.yourCurrency)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(Color.gray.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                TextField("Quantity", value: $viewModel.amount, format: .number)
                    .font(.headline)
                    .keyboardType(.decimalPad)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .focused($amountIsFocused)
                
                
                Text("I receive")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundColor(.gray)

                Button {
                    wannaCurrencySheet = true
                } label: {
                    Text("\(viewModel.wannaCurrency.getFlag()) \(viewModel.wannaCurrency)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(Color.gray.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Text(String(round(viewModel.result * 1000)/1000))
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    Task {
                        await viewModel.loadData()
                    }
                } label: {
                    Text("Convert")
                        .font(.headline)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical)
                }
                
                Spacer()
            }
            .navigationTitle("Currency Exchange")
            .sheet(isPresented: $yourCurrencySheet) {
                ChooseCurrency(chosenCurrency: $viewModel.yourCurrency)
            }
            .sheet(isPresented: $wannaCurrencySheet) {
                ChooseCurrency(chosenCurrency: $viewModel.wannaCurrency)
            }
        }
        .task{
            await viewModel.loadData()
        }
        .onTapGesture {
            amountIsFocused = false
        }
    }
}

struct CurrencyExchange_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchange()
    }
}



