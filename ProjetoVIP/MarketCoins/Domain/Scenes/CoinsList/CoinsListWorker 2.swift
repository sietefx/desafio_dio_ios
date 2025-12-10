import UIKit

class CoinsListWorker {
    
    private let dataProvider: CoinListDataProvider?
    private var completion: ((Result<[CoinModel]?, CryptocurrenciesError>) -> Void)?
    
    // ✅ Correção 1: nome do store deve coincidir com o tipo real (CoinStore → CoinsStore)
    init(dataProvider: CoinListDataProvider = CoinListDataProvider(coinStore: CoinStore())) {
        self.dataProvider = dataProvider
        self.dataProvider?.delegate = self
    }
    
    func doFetchListCoins(baseCoin: String,
                          orderBy: String,
                          top: Int,
                          percentagePrice: String,
                          completion: @escaping (Result<[CoinModel]?, CryptocurrenciesError>) -> Void) {
        self.completion = completion
        print("📡 Worker: iniciando fetchListCoins para \(baseCoin.uppercased()), filtro \(percentagePrice)")
        
        // ✅ Correção 2: garanta que `percentagePrice` não quebre a URL
        dataProvider?.fetchListCoins(
            by: baseCoin,
            with: nil,
            orderBy: orderBy,
            total: top,
            page: 1,
            percentagePrice: percentagePrice.lowercased()
        )
    }
}

// MARK: - CoinListDataProviderDelegate
extension CoinsListWorker: CoinListDataProviderDelegate {
    
    func success(model: Any) {
        guard let completion = completion else {
            assertionFailure("❌ Completion handler não implementado!")
            return
        }
        
        print("✅ Worker: sucesso no fetch de moedas")
        completion(.success(model as? [CoinModel]))
    }
    
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error) {
        guard let completion = completion else {
            assertionFailure("❌ Completion handler não implementado!")
            return
        }
        
        let nsError = error as NSError
        let cryptoError: CryptocurrenciesError
        
        switch nsError.code {
        case 500:
            cryptoError = .internalServerError
        case 400:
            cryptoError = .badRequestError
        case 404:
            cryptoError = .notFoundError
        default:
            cryptoError = .undefinedError
        }
        
        print("🚫 Worker: erro ao buscar moedas (\(nsError.code))")
        completion(.failure(cryptoError))
    }
}
