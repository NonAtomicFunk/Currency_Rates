//
//  NavController.swift
//  currency_exchange
//
//  Created by atomic on 08.02.2021.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func presentPickerController() {
        guard let pickerVC = self.storyboard?.instantiateViewController(identifier: "CurrencyPickerController") as? CurrencyPickerController else {
            return
        }
        
        self.pushViewController(pickerVC, animated: true)
    }
    
    public func currencySelected(_ currencyPair: [String]) {
        
        guard let pickerVC = self.storyboard?.instantiateViewController(identifier: "CurrencyPickerController") as? CurrencyPickerController else {
            return
        }
        
        if currencyPair.count == 1 {
            
            pickerVC.selectedCurrency = currencyPair
            
            self.pushViewController(pickerVC, animated: true)
            
        } else if currencyPair.count == 2 {

            self.popToViewController(ViewController.self, pair: currencyPair)
        }
    }
}
