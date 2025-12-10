//
//  GenericDataProvider.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

protocol GenericDataProviderDelegate {
    func success(model: Any)
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error)
}

class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
