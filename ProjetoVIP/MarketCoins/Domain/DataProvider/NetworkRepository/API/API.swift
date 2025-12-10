
//
//  Untitled.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

struct API {
    static let baseURL = "https://api.coingecko.com/api/v3"

    // 🔹 Lista de moedas com dados de mercado
    static let coinsMarket = "/coins/markets"
    
    // 🔹 Dados de mercado por intervalo de tempo (precisa de coinId)
    static let coinsByMarketChart = "/coins/%@/market_chart/range"
    
    // 🔹 Dados OHLC (Open, High, Low, Close)
    static let coinsByIdOhlc = "/coins/%@/ohlc"
    
    // 🔹 Dados globais do mercado
    static let global = "/global"
    
    // 🔹 Dados detalhados de uma moeda específica (corrigido)
    static let coinsById = "/coins/%@"
}
