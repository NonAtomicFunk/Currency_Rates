//
//  CurrencyPickerController.swift
//  currency_exchange
//
//  Created by atomic on 08.02.2021.
//

import UIKit

class CurrencyPickerController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var currencyArray: [CountryModel] = []
    public var selectedCurrency: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setuptable()
    }
    
    
    fileprivate func setuptable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        
        self.currencyArray = Constants.shared.countryArray
        
        self.tableView.register(UINib(nibName: "CurrencyPickerCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "CurrencyPickerCell")
        
        self.tableView.reloadData()
    }
    
    fileprivate func setupView() {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}



extension CurrencyPickerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyPickerCell",
                                                       for: indexPath) as? CurrencyPickerCell else {
            return UITableViewCell()
        }
        
        let model = self.currencyArray[indexPath.row]
        
        cell.currencyIndexLabel.text = model.currencyIndex.uppercased()
        cell.currencyNameLabel.text = model.currencyName.capitalized
        cell.currencyImageView.image = UIImage(named: model.currencyIndex) ?? UIImage(named: "flag_placeholder")
        
        let preSelectedCurrency = self.selectedCurrency.first ?? ""
        
        if preSelectedCurrency != "" && cell.currencyIndexLabel.text! == preSelectedCurrency {
            cell.isUserInteractionEnabled = false
            
            cell.currencyImageView.layer.opacity = 0.5
            cell.currencyIndexLabel.layer.opacity = 0.5
            cell.currencyNameLabel.layer.opacity = 0.5
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyPickerCell else {
            return
        }
        
        cell.currencyImageView.layer.opacity = 0.5
        cell.currencyIndexLabel.layer.opacity = 0.5
        cell.currencyNameLabel.layer.opacity = 0.5
        
        self.selectedCurrency.append(cell.currencyIndexLabel.text!)
        
        (self.navigationController as? NavController)?.currencySelected(self.selectedCurrency)
    }
    
}
