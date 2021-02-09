//
//  CurrencyPairCell.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import UIKit

class CurrencyPairCell: UITableViewCell {

    
    @IBOutlet weak var leftCurrencyInfo: UILabel!
    @IBOutlet weak var leftCurrencyName: UILabel!
    
    @IBOutlet weak var rightCurrencyInfo: UILabel!
    @IBOutlet weak var rightCurrencyName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
