//
//  ViewController.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataModels: [CurrencyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
    }

    fileprivate func addCurrency(_ currencyAdded: String) {
//        var currencyPair: [String]
    }

    fileprivate func getRates() {
//        let restService = RestService.shared
    }
    
    fileprivate func setupView() {
        self.title = "Rates & converter"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyPairCell", for: indexPath) as? CurrencyPairCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

