//
//  GlobalValuesViewCell.swift
//  MarketCoins
//
//  Created by Gabriel Felix on 06/11/25.
//

import UIKit

class GlobalValuesViewCell: UICollectionViewCell {

    static let indetifier = "GlobalValuesViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            contentView.layer.cornerRadius = 8
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.systemGray5.cgColor
        }

        func configure(with model: CoinsList.FetchGlobalValues.ViewModel.GlobalValues) {
            titleLabel.text = model.title
            valueLabel.text = model.value
        }
}
