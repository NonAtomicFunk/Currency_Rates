//
//  RestService.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import Foundation

final class RestService {
    
    static let shared = RestService()
    var decodedData: [CurrencyModel] = []
    typealias JSONDictionary = [String: Any]
    
    var errorMessage = ""
    
    typealias QueryResult = ([CurrencyModel]?, String) -> Void
    var dataTask: URLSessionDataTask?
    
    private init() {
        
    }
    
    func getRates(_ selectedPairs: [SelectedCurrency],
                  completion: @escaping QueryResult) {
        
//        self.dataTask?.cancel()
        var urlString = Constants.basicURLString
        
//        for item in selectedPairs {
//            let appendableString: String = item.leftCurrency+item.rightCurrency
//            urlString.append(appendableString)
//        }
        for (index, item) in selectedPairs.enumerated() {
            if index == 0 {
                let appendableString: String = "?pairs="+item.leftCurrency+item.rightCurrency
                urlString.append(appendableString)
            } else {
                let appendableString: String = "&pairs="+item.leftCurrency+item.rightCurrency
                urlString.append(appendableString)
            }
        }
        
        print(urlString, "!!!")
        let url: URL = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let fetchTask = URLSession(configuration: .default).dataTask(with: request) { [weak self] data, response, error in
        
            self?.errorMessage = ""
            
            defer {
              self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
              
              self?.decodeResults(data)
              
              // 6
              DispatchQueue.main.async {
                completion(self?.decodedData, self?.errorMessage ?? "")
              }
            }

//            if let data = data {
//                do {
//                    print(response, "???")
////                    let datasourceDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Float]
////
////                    print(response, data, datasourceDictionary)
////
////                    let model = CurrencyModel(lefTitle: "",
////                                              rightTitle: "",
////                                              rightAmmount: "")
//                } catch {
//                    print("ERROR: ", error)
//                }
//            }
//
//            if error != nil {
//                print("Error: ", error)
//            }
        }
        fetchTask.resume()
    }
    
    fileprivate func decodeResults(_ data: Data) {
        
        var decodedDict: JSONDictionary?
//        self.decodedData.removeAll()
        
        
        do {
            decodedDict = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
            
            
        } catch let parseError as NSError {
          errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
          return
        }
        
        guard let dataArray = decodedDict else {
            return
        }
        
        for dict in dataArray {
            let name = dict.key
            let amount = dict.value
            
            let model = CurrencyModel(lefTitle: name[0..<3],
                                      rightTitle: name[3..<6],
                                      rightAmmount: String(describing: amount))
            print(model)
        }
        
        print(dataArray, "******")

    }
}
