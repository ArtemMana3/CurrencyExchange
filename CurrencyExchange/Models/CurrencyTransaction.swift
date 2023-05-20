//
//  CurrencyTransaction.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import Foundation
import RealmSwift

class TransactionCurrency: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var amount: Double
    @Persisted var comment: String = ""
    @Persisted var date: Date = Date.now
    @Persisted var accountId: String?
}
