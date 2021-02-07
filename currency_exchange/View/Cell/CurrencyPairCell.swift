//
//  CurrencyPairCell.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import UIKit

class CurrencyPairCell: UITableViewCell {

    
    @IBOutlet weak var currencyIndex0: UILabel!
    @IBOutlet weak var currencyName0: UILabel!
    
    @IBOutlet weak var currencyIndex1: UILabel!
    @IBOutlet weak var currencyName1: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
