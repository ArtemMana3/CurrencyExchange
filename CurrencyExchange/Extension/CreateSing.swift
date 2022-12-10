//
//  FlagOrSymbol.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 09.12.2022.
//

import Foundation

extension String {
    func getSymbol() -> String? {
        let locale = NSLocale(localeIdentifier: self)
        if locale.displayName(forKey: .currencySymbol, value: self) == self {
            let newlocale = NSLocale(localeIdentifier: self.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: self)
        }
        return locale.displayName(forKey: .currencySymbol, value: self)
    }
    
    func getFlag() -> String {
        let base = 127397
        
        var code = self
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16 {
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        return String(scalar)
    }
}
