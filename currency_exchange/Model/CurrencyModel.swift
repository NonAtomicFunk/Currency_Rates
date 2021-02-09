//
//  CurrencyModel.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import Foundation

struct CurrencyModel {
    
    let leftCurrencyTitle: String
    let leftAmmount: String
    
    let rightCurrencyTitle: String
    let rightAmmount: String
    
    init(lefTitle: String,
         rightTitle: String,
         rightAmmount: String) {
        
        self.leftCurrencyTitle = lefTitle
        self.leftAmmount = "1"
        self.rightCurrencyTitle = rightTitle
        self.rightAmmount = rightAmmount
    }
}
