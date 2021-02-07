//
//  RestService.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import Foundation

final class RestService {
    
    static let shared = RestService()
    
    static let basicURLString: String = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios"
    
    private init() {
        
    }
}
