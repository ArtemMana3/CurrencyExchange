//
//  TransactionCurrency.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import Foundation
import RealmSwift

extension TransactionCurrency {
    static func getAllTransaction() -> [TransactionCurrency] {
        let realm = try! Realm()
        return realm.objects(TransactionCurrency.self).compactMap { return $0 }
    }
    
    func save() {
        let realm = try! Realm()
        try? realm.write {
            realm.add(self)
        }
    }
    
    func delete() {
        let realm = try! Realm()
        
        try? realm.write {
            guard let transaction = realm.objects(TransactionCurrency.self).where({
                $0._id == self._id
            }).first else { return }
            realm.delete(transaction)
        }
    }
}
