//
//  CurrentDataModel.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

struct CurrentDataModel: Codable {
    let id: String
    let symbol: String
    let name: String
    let currentDataDescription: [String: String]
    let marketCapRank: Int?
    let image: ImageModel
    let marketData: MarketDataModel
    let lastupdated: Date
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case currentDataDescription = "description"
        case marketCapRank = "market_cap_rank"
        case image
        case marketData = "market_data"
        case lastupdated = "last_updated"
    }
}
//MARK - ImageModel
struct ImageModel: Codable {
    let small: String
    let large: String
    let thumb: String
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let currentPrice: [String: Double]?
    let marketCap: [String: Double]?
    let totalVolume: [String: Double]?
    let high24H: [String: Double]?
    let low24H: [String: Double]?
    let priceChangePercentage1H: Double?
    let priceChangePercentage24H: Double?
    let priceChangePercentage7D: Double?
    let priceChangePercentage30D: Double?
    let ath: [String: Double]?
    let athChangePercentage: [String: Double]?
    let athDate: [String: String]?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChangePercentage1H = "price_change_percentage_1h_in_currency"
            case priceChangePercentage24H = "price_change_percentage_24h_in_currency"
            case priceChangePercentage7D = "price_change_percentage_7d_in_currency"
            case priceChangePercentage30D = "price_change_percentage_30d_in_currency"
            case ath
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case lastUpdated = "last_updated"
    }
}
