//
//  UINavigationController+Extensions.swift
//  currency_exchange
//
//  Created by atomic on 09.02.2021.
//

import UIKit

extension UINavigationController {
    
    func popToViewController(_ ofClass: AnyClass, pair: [String], animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            if let viewControlelr = vc as? ViewController {
                
                let selectedPair = SelectedCurrency(leftCurrency: pair.first!,
                                                    rightCurrency: pair.last!)
                
                for item in viewControlelr.preSelectedCurrency {
                    if item.leftCurrency == selectedPair.leftCurrency && item.rightCurrency == selectedPair.rightCurrency {
                        popToViewController(viewControlelr, animated: animated)
                        return
                    }
                }
                
                viewControlelr.preSelectedCurrency.append(selectedPair)
                popToViewController(viewControlelr, animated: animated)
            }
        }
    }
}
