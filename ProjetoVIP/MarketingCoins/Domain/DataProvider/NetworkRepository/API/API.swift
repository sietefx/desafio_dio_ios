
//
//  Untitled.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

struct API {
    
    static let baseURL = "https://api.coingecko.com/api/v3"
    static let coinsMarket = "/coins/markets"
    static let coinsByMarketChart = "/coins/%@/market_chart/range"
    static let coinsByIdOhlc = "/coins/%@/ohlc"
    static let global = "/global"
    static let coinsById = "coins/%@"
}
