//
//  CurrencyAccount.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 20.05.2023.
//

import SwiftUI
import RealmSwift

class CurrencyAccount: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var amount: Double
    @Persisted var currency: String
}
