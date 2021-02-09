//
//  CurrencyPickerCell.swift
//  currency_exchange
//
//  Created by atomic on 07.02.2021.
//

import UIKit

class CurrencyPickerCell: UITableViewCell {

    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyIndexLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
