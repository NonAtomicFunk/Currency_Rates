//
//  ViewController.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var addPairButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    public var preSelectedCurrency: [SelectedCurrency] = []
    
    fileprivate var dataModels: [CurrencyModel] = [] {
        didSet {
            self.shouldHideTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //reset table, goto rest
        getRates()
    }

    fileprivate func addCurrency(_ currencyAdded: String) {
//        var currencyPair: [String]
    }

    fileprivate func getRates() {
//        let restService = RestService.shared
        
        guard !self.preSelectedCurrency.isEmpty else {
            return
        }
        
//        RestService.shared.getRates(self.preSelectedCurrency/*,
//                                    completion: self.resetTable*/)
        RestService.shared.getRates(self.preSelectedCurrency) {  [weak self] results, errorMessage in
            if let result = results {
                self?.resetTable(result)
            }
        }
        
        
    }
    
    fileprivate func resetTable(_ data: [CurrencyModel]) {
        
    }
    
    fileprivate func setupView() {
        self.title = "Rates & converter"
        self.addPairButton.addTarget(self,
                                     action: #selector(self.presentPickerController),
                                     for: .touchUpInside)
    }
    
    fileprivate func shouldHideTable() {
        if self.dataModels.isEmpty {
            self.tableView.isHidden = true
            self.tableView.isUserInteractionEnabled = false
            
            self.emptyView.isHidden = false
            self.emptyView.isUserInteractionEnabled = true
            
        } else {
            self.tableView.isHidden = false
            self.tableView.isUserInteractionEnabled = true
            
            self.emptyView.isHidden = true
            self.emptyView.isUserInteractionEnabled = false
        }
    }
    
    @objc func presentPickerController() {
        guard let rootNav = self.navigationController as? NavController else {
            return
        }
        rootNav.presentPickerController()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.shouldHideTable()
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

