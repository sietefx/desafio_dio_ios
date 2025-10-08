//
//  GlobalModel.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

struct GlobalModel: Codable {
    let data: CryptocurrencyModel
}

// MARK - CryptocurrencyModel
struct CryptocurrencyModel: Codable {
    let activeCryptocurrencies: Int
    let upcomingIcos: Int
    let ongoingIcos: Int
    let endedIcos: Int
    let markets: Int
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapPercentage24hUsd: [String: Double]
    let updatedAt: Int // data de atualização do timestamp
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapPercentage24hUsd = "market_cap_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
}
