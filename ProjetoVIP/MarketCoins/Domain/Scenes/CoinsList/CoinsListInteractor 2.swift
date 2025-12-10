//
//  CoinsListInteractor.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CoinsListBusinessLogic {
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request)
    func doFetchListCoins(request: CoinsList.FetchCoinsList.Request)
}

protocol CoinsListDataStore {
    //var name: String { get set }
}

class CoinsListInteractor: CoinsListBusinessLogic, CoinsListDataStore {
    
    var presenter: CoinsListPresentationLogic?
    var globalValuesWorker: GlobalValuesWorker?
    var coinListWorker: CoinsListWorker?
    
    init(presenter: CoinsListPresentationLogic = CoinsListPresenter(),
         globalValuesWorker: GlobalValuesWorker = GlobalValuesWorker(),
         coinListWorker: CoinsListWorker? = CoinsListWorker()) {
        
        self.presenter = presenter
        self.globalValuesWorker = globalValuesWorker
        self.coinListWorker = coinListWorker
    }
    
    // MARK: - Global Values
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request) {
        print("🔵 Interactor: recebida requisição global com baseCoin: \(request.baseCoin)")
        globalValuesWorker?.doFetchGlobalValues(completion: { result in
            switch result {
            case .success(let globalModel):
                print("✅ Interactor recebeu GlobalModel:", globalModel as Any)
                self.createGlobalValuesResponse(baseCoin: request.baseCoin, global: globalModel)
            case .failure(let error):
                self.presenter?.presentError(error: error)
                print("❌ Erro no Interactor (GlobalValuesWorker):", error)
            }
        })
    }
    
    private func createGlobalValuesResponse(baseCoin: String, global: GlobalModel?) {
        if let global {
            let totalMarketCap = global.data.totalMarketCap.filter { $0.key == baseCoin }
            let totalVolume = global.data.totalVolume.filter { $0.key == baseCoin }
            
            let response = CoinsList.FetchGlobalValues.Response(
                baseCoin: baseCoin,
                totalMarketCap: totalMarketCap,
                totalVolume: totalVolume
            )
            
            presenter?.presentGlobalValues(response: response)
        } else {
            self.presenter?.presentError(error: .undefinedError)
        }
    }
    
    // MARK: - Coins List
    func doFetchListCoins(request: CoinsList.FetchCoinsList.Request) {
        print("🟢 Interactor: recebida requisição de moedas com filtro: \(request.pricePercentage)")
        let baseCoin = request.baseCoin
        let orderBy = request.orderBy
        let top = request.top
        let percentagePrice = request.pricePercentage
        
        coinListWorker?.doFetchListCoins(baseCoin: baseCoin,
                                         orderBy: orderBy,
                                         top: top,
                                         percentagePrice: percentagePrice,
                                         completion: { result in
            switch result {
            case .success(let listCoinsModel):
                print("✅ Interactor recebeu listCoins:", listCoinsModel!.count)
                self.createListCoinsResponse(request: request, listCoins: listCoinsModel)
            case .failure(let error):
                self.presenter?.presentError(error: error)
                print("❌ Erro no Interactor (ListCoinsWorker):", error)
            }
        })
    }
    
    private func createListCoinsResponse(request: CoinsList.FetchCoinsList.Request, listCoins: [CoinModel]?) {
        guard let listCoins else {
            print("Nenhuma coin encontrada")
            self.presenter?.presentError(error: .undefinedError)
            return
        }
        
        func priceChangePercentage(for coin: CoinModel) -> Double {
            switch request.pricePercentage {
            case "1h":
                return coin.priceChangePercentage1H ?? 0.0
            case "24h":
                return coin.priceChangePercentage24H ?? 0.0
            case "7d":
                return coin.priceChangePercentage7D ?? 0.0
            default:
                return coin.priceChangePercentage30D ?? 0.0
            }
        }
        
        let responses = listCoins.map { coin in
            CoinsList.FetchCoinsList.Response(
                baseCoin: request.baseCoin,
                id: coin.id,
                symbol: coin.symbol,
                name: coin.name,
                image: coin.image ?? "",
                currentPrice: coin.currentPrice ?? 0.0,
                marketCap: coin.marketCap ?? 0.0,
                marketCapRank: coin.marketCapRank,
                priceChangePercentage: priceChangePercentage(for: coin)
            )
        }
        
        presenter?.presentListCoins(response: responses)
    }
}
