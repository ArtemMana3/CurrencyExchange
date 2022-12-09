//
//  DataController.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 13.11.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ExchangeHistory")
    @Published var transactions = [Transaction]()
    
    init() {
        container.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        })
        fetchTransaction()
    }
    
    func fetchTransaction() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)]
        do {
            transactions = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        for offset in offsets {
            let transaction = transactions[offset]
            container.viewContext.delete(transaction)
        }

        try? container.viewContext.save()
    }
    
    func addTransaction(quantity: Int, yourCurrency: String, quantityPurchased: Int, currencyPurchased: String) {
        let newTransaction = Transaction(context: container.viewContext)
        newTransaction.id = UUID()
        newTransaction.quantity = Int32(quantity)
        newTransaction.yourCurrency = yourCurrency
        newTransaction.quantityPurchased = Int32(quantityPurchased)
        newTransaction.currencyPurchased = currencyPurchased
        newTransaction.date = Date.now

        try? container.viewContext.save()
        fetchTransaction()
        
    }
}
