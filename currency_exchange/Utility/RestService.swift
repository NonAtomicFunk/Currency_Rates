//
//  RestService.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import Foundation

final class RestService {
    
    static let shared = RestService()
    
    typealias QueryResult = ([CurrencyModel]?) -> Void
//    var dataTask: URLSessionDataTask?
    
    private init() {
        
    }
    
    func getRates(_ selectedPairs: [SelectedCurrency]/*,
                  completion: @escaping (QueryResult) */) {
        
//        self.dataTask?.cancel()
        var urlString = Constants.basicURLString
        
//        for item in selectedPairs {
//            let appendableString: String = item.leftCurrency+item.rightCurrency
//            urlString.append(appendableString)
//        }
        for (index, item) in selectedPairs.enumerated() {
            if index == 0 {
                let appendableString: String = "?"+item.leftCurrency+item.rightCurrency
                urlString.append(appendableString)
            } else {
                let appendableString: String = "&"+item.leftCurrency+item.rightCurrency
                urlString.append(appendableString)
            }
        }
        
        let url: URL = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let fetchTask = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
        
            if let data = data {
                do {
                    let datasourceDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: String]
                    
                    print(response, data, datasourceDictionary)
                } catch {
                    print("ERROR: ", error)
                }
            }
        
            if error != nil {
            }
        }
        fetchTask.resume()
    }
}
