//
//  ListCoinDataProvider.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

protocol CoinListDataProviderDelegate: GenericDataProviderDelegate {}

final class CoinListDataProvider: DataProviderManager<CoinListDataProviderDelegate, [CoinModel]> {
    // Make the store non-optional to simplify usage and avoid optional-call mistakes
    private let coinsStore: CoinsStoreProtocol

    // Do not use an instance member as a default parameter. Provide a static factory instead.
    init(coinsStore: CoinsStoreProtocol) {
        self.coinsStore = coinsStore
    }

    func fetchListCoins(
        by vsCurrency: String,
        with cryptocurrency: [String]?,
        orderBy order: String,
        total perPage: Int,
        page: Int,
        percentagePrice: String
    ) {
        coinsStore.fetchListCoins(
            by: vsCurrency,
            with: cryptocurrency,
            orderBy: order,
            total: perPage, page: page,
            percentagePrice: percentagePrice,
            completion: { [weak self] result, error in
                guard let self else { return }

                if let error = error {
                    self.delegate?.errorData(self.delegate, error: error)
                    return
                }

                if let result = result {
                    self.delegate?.success(model: result)
                }
            }
        )
    }
}

