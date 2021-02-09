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
    
    public var preSelectedCurrency: [SelectedCurrency] = []
    fileprivate var dataModels: [CurrencyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideUnhideTable()
    }


    fileprivate func getRates() {
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
        
        self.headerViewButton.addTarget(self,
                                        action: #selector(presentPickerController),
                                        for: .touchUpInside)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.presentPickerController))
        self.headerView.addGestureRecognizer(gesture)
    }
    
    fileprivate func hideUnhideTable() {
        
        self.tableView.isHidden = self.preSelectedCurrency.isEmpty
        self.tableView.isUserInteractionEnabled = !self.preSelectedCurrency.isEmpty
        
        self.headerView.isHidden = self.preSelectedCurrency.isEmpty
        self.headerView.isUserInteractionEnabled = !self.preSelectedCurrency.isEmpty
        
        self.emptyView.isHidden = !self.preSelectedCurrency.isEmpty
        self.emptyView.isUserInteractionEnabled = self.preSelectedCurrency.isEmpty
        
        if !self.preSelectedCurrency.isEmpty {
            
            self.getRates()
        }
    }
    
    func getnameForInsder(_ index: String) -> String {
        let dict = Constants.shared.indexToNameDictionary
        
        let curencyName = dict[index] ?? ""
        
        return curencyName
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
        self.tableView.estimatedRowHeight = 111.0
        self.tableView.register(UINib(nibName: "CurrencyPairCell", bundle: nil),
                                forCellReuseIdentifier: "CurrencyPairCell")
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.dataModels.remove(at: indexPath.row)
            self.preSelectedCurrency.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if self.dataModels.count == 0 {
                self.hideUnhideTable()
            }
        }
    }
}
