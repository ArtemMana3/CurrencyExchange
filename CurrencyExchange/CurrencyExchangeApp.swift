//
//  CurrencyExchangeApp.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 12.11.2022.
//

import SwiftUI

@main
struct CurrencyExchangeApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
