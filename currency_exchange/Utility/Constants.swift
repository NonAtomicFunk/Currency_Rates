//
//  Constants.swift
//  currency_exchange
//
//  Created by atomic on 08.02.2021.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    
    private init() {
        self.makeMock()
    }
    
    let title: String = "Rates & converter"
    
    var countryArray: [CountryModel] = []
    
    static let basicURLString: String = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios"
    
    static let currencyIndex: [String] = [
        "AUD",
        "BGN",
        "BRL",
        "CAD",
        "CHF",
        "CNY",
        "CZK",
        "DKK",
        "EUR",
        "GBP",
        "HKD",
        "HRK",
        "HUF",
        "IDR",
        "ILS",
        "INR",
        "ISK",
        "JPY",
        "KRW",
        "MXN",
        "MYR",
        "NOK",
        "NZD",
        "PHP",
        "PLN",
        "RON",
        "RUB",
        "SEK",
        "SGD",
        "THB",
        "USD",
        "ZAR"
    ]
    
    static let currencyName: [String] = [
        "United Arab Emirates Dirham",
        "Bulgarian lev",
        "Brazilian real",
        "Canadian dollar",
        "Swiss franc",
        "Renminbi",
        "Czech koruna",
        "Danish krone",
        "Euro",
        "The British pound",
        "Hong Kong dollar",
        "Croatian kuna",
        "Hungarian forint",
        "Indonesian rupiah",
        "Israeli Shekel",
        "Indian rupee",
        "Icelandic króna",
        "Japanese yen",
        "South Korean won",
        "Mexican peso",
        "Malaysian ringgit",
        "Norwegian krone",
        "New Zealand dollar",
        "Philippine peso",
        "Polish złoty",
        "Romanian leu",
        "Russian ruble",
        "Swedish krona",
        "Singapore dollar",
        "Thai baht",
        "United states dollar",
        "South African rand"
    ]
    
    static let currencyIcun: [String] = [
        
    ]
    
    func makeMock() {
        var index = 0
        for item in Constants.currencyIndex {
            
            let model = CountryModel(currencyIndex: item, currencyName: Constants.currencyName[index])
            self.countryArray.append(model)
            index += 1
        }
    }
}
