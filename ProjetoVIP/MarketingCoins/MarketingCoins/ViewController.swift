//
//  ViewController.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataProvider = CoinListDataProvider(coinsStore: CoinStore())
        dataProvider.delegate = self
        dataProvider.fetchListCoins(by: "brl", with: (nil as [String]?), orderBy: "market_cap_desc", total: 10, page: 1, percentagePrice: "1h")
    }


}

extension ViewController: CoinListDataProviderDelegate {
    func success(model: Any) {
        let coinList = model as? [CoinModel]
        print(coinList ?? "Vazio")
    }
    
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error) {
        print(error.localizedDescription)
    }
}
