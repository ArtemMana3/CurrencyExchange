//
//  CurrencyAccountExtansion.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import Foundation
import RealmSwift

extension CurrencyAccount {
    static func getAllAccounts() -> [CurrencyAccount] {
        let realm = try! Realm()
        return realm.objects(CurrencyAccount.self).compactMap { return $0 }
    }
    
    func save() {
        let realm = try! Realm()
        try? realm.write {
            realm.add(self)
        }
    }
    
    func findCurrencyAccount() -> CurrencyAccount {
        let realm = try! Realm()
        guard let account = realm.objects(CurrencyAccount.self).where({
            $0._id == self._id
        }).first else
        {
            return CurrencyAccount()
        }
        return account
    }
    
    func updateAmount(amount: Double) {
        let realm = try! Realm()
        let account = self.findCurrencyAccount()
        try? realm.write {
            account.amount += amount
        }
    }
    
    func delete() {
        let realm = try! Realm()
        
        try? realm.write {
            guard let account = realm.objects(CurrencyAccount.self).where({
                $0._id == self._id
            }).first else { return }
            realm.delete(account)
        }
    }
}
