//
//  FlagOrSymbol.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 09.12.2022.
//

import Foundation

protocol FlagOrSymbol {
    func getSymbol(forCurrencyCode code: String) -> String?
    func getFlag(currency: String) -> String
}

extension FlagOrSymbol {
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    func getFlag(currency: String) -> String {
        let base = 127397
        
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16 {
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        return String(scalar)
    }
}
