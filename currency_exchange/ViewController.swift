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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    public var preSelectedCurrency: [SelectedCurrency] = [] //{
//        didSet {
//            self.shouldHideTable()
//        }
//    }
    fileprivate var dataModels: [CurrencyModel] = []
    
//    fileprivate var dataModels: [CurrencyModel] = [] {
//        didSet {
//            self.shouldHideTable()
//        }
//    }
    
    //RestService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //reset table, goto rest
//        getRates()
        self.hideUnhideTable()
    }

    fileprivate func addCurrency(_ currencyAdded: String) {
//        var currencyPair: [String]
    }

    fileprivate func getRates() {
//        let restService = RestService.shared
        
//        guard !self.preSelectedCurrency.isEmpty else {
//            return
//        }
        
//        RestService.shared.getRates(self.preSelectedCurrency/*,
//                                    completion: self.resetTable*/)
        RestService.shared.getRates(self.preSelectedCurrency) {  [weak self] results, errorMessage in
            if let result = results {
                self?.resetTable(result)
            }
        }
        
        
    }
    
    fileprivate func resetTable(_ data: [CurrencyModel]) {
        self.dataModels = data
        self.tableView.reloadData()
    }
    
    fileprivate func setupView() {
        self.title = Constants.shared.title
        
        self.addPairButton.addTarget(self,
                                     action: #selector(self.presentPickerController),
                                     for: .touchUpInside)
    }
    
    fileprivate func hideUnhideTable() {
        
        self.tableView.isHidden = self.preSelectedCurrency.isEmpty
        self.tableView.isUserInteractionEnabled = !self.preSelectedCurrency.isEmpty
        
        self.headerView.isHidden = self.preSelectedCurrency.isEmpty
        self.headerView.isUserInteractionEnabled = !self.preSelectedCurrency.isEmpty
        
        self.emptyView.isHidden = !self.preSelectedCurrency.isEmpty
        self.emptyView.isUserInteractionEnabled = self.preSelectedCurrency.isEmpty
        
        if !self.preSelectedCurrency.isEmpty {
//            self.tableView.isHidden = true
//            self.tableView.isUserInteractionEnabled = false
//
//            self.headerView.isHidden = true
//            self.headerView.isUserInteractionEnabled = false
//
//            self.emptyView.isHidden = false
//            self.emptyView.isUserInteractionEnabled = true
            
//        } else {
//            self.tableView.isHidden = false
//            self.tableView.isUserInteractionEnabled = true
//
//            self.emptyView.isHidden = true
//            self.emptyView.isUserInteractionEnabled = false
            
            self.getRates()
//            RestService.shared. todo
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
        self.tableView.estimatedRowHeight = 111.0 //56.0
        self.tableView.register(UINib(nibName: "CurrencyPairCell", bundle: nil),
                                forCellReuseIdentifier: "CurrencyPairCell")
        
        self.headerViewButton.addTarget(self,
                                        action: #selector(presentPickerController),
                                        for: .touchUpInside)
        
        self.tableView.separatorColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CurrencyPairCell", for: indexPath) as? CurrencyPairCell else {
            return UITableViewCell()
        }
        
        let model = self.dataModels[indexPath.row]
        
        cell.leftCurrencyInfo.text = model.leftAmmount+" "+model.leftCurrencyTitle
        cell.leftCurrencyName.text = self.getnameForInsder(model.leftCurrencyTitle).uppercased()
        
        cell.rightCurrencyInfo.text = model.rightAmmount+" "+model.rightCurrencyTitle
        cell.rightCurrencyName.text = self.getnameForInsder(model.rightCurrencyTitle).uppercased()
        
        return cell
    }
    
    func getnameForInsder(_ index: String) -> String {
        let dict = Constants.shared.indexToNameDictionary
        
        let curencyName = dict[index] ?? "WAS"
        
        return curencyName
    }
    /// register Header
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as? TableHeader else {
//            return nil
//        }
//
////        headerView.addButton.addTarget(self,
////                                        action: #selector(self.presentPickerController),
////                                        for: .touchUpInside)
//
//        return headerView
//    }
//
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 120
//    }
}

