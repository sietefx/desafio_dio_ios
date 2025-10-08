import Foundation

protocol CoinsStoreProtocol: GenericStoreProtocol {
    func fetchListCoins(by vsCurrency: String,
                        with cryptocurrency: [String]?,
                        orderBy order: String,
                        total perPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion<[CoinModel]?>)

    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         from: String,
                         to: String,
                         completion: @escaping completion<[MarketChartModel]?>)

    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>)

    func fetchCoin(by id: String,
                   completion: @escaping completion<CurrentDataModel?>)
}

class CoinStore: GenericStoreRequest, CoinsStoreProtocol {

    func fetchListCoins(by vsCurrency: String,
                        with cryptocurrency: [String]?,
                        orderBy order: String,
                        total perPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion<[CoinModel]?>) {
        do {
            let request = try CoinRouter.coinsMarket(
                vsCurrency: vsCurrency,
                cryptocurrency: cryptocurrency,
                order: order,
                perPage: perPage,
                page: page,
                percentage: percentagePrice
            ).asURLRequest()
            self.request(urlRequest: request, completion: completion)
        } catch {
            completion(nil, error)
        }
    }

    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         from: String,
                         to: String,
                         completion: @escaping completion<[MarketChartModel]?>) {
        do {
            let request = try CoinRouter.historicalMarket(
                id: id,
                vsCurrency: vsCurrency,
                from: from,
                to: to
            ).asURLRequest()
            self.request(urlRequest: request, completion: completion)
        } catch {
            completion(nil, error)
        }
    }

    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>) {
        do {
            let request = try CoinRouter.coinsByIdOhlc(
                id: id,
                currency: vsCurrency,
                days: days
            ).asURLRequest()
            self.request(urlRequest: request, completion: completion)
        } catch {
            completion(nil, error)
        }
    }

    func fetchCoin(by id: String,
                   completion: @escaping completion<CurrentDataModel?>) {
        do {
            let request = try CoinRouter.coinsById(id: id).asURLRequest()
            self.request(urlRequest: request, completion: completion)
        } catch {
            completion(nil, error)
        }
    }
}
