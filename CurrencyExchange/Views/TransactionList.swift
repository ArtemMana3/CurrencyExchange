//
//  TransactionList.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import SwiftUI
import RealmSwift

struct TransactionList: View {
    @State var account: CurrencyAccount
    @ObservedResults(TransactionCurrency.self) var transactions
    @State private var showAlert = false

    
    var body: some View {
        List {
            ForEach(transactions, id: \.self) { transaction in
                if account._id.stringValue == transaction.accountId {
                    HStack {
                        Text("\(account.currency.getSymbol() ?? "$")\(String(round(transaction.amount * 100)/100))")
                            .font(.title2)
                        VStack(alignment: .leading) {
                            if !transaction.comment.isEmpty {
                                Text("Comment: \(transaction.comment)")
                            }
                            Text(formatDate(date: transaction.date))
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItem)

        }
        .toolbar {
            Button(action: {
                showAlert = true
            }) {
                Image(systemName: "trash")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Delete"),
                  message: Text("Are you sure you want to delete this currency account?"),
                  primaryButton: .default(Text("Yes, I am"), action: {
                deleteSelectedItem()
            }),
                  secondaryButton: .cancel()
            )
            
        }
        .navigationTitle("Transaction list")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteSelectedItem() {
        account.delete()
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            account.updateAmount(amount: -transactions[index].amount)
            transactions[index].delete()
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

//struct TransactionList_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionList()
//    }
//}
