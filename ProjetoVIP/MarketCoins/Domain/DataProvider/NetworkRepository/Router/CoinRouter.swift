//
//  CoinRouter.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

enum CoinRouter {
    
    case coinsMarket(vsCurrency: String,
                     cryptocurrency: [String]?,
                     order: String,
                     perPage: Int,
                     page: Int,
                     percentage: String)
    case historicalMarket(id: String,
                          vsCurrency: String,
                          from: String,
                          to: String)
    case coinsByIdOhlc(id: String,
                       currency: String,
                       days: String)
    case coinsById(id: String)
    
    // MARK: - Caminho relativo da API
    var path: String {
        switch self {
        case .coinsMarket:
            return API.coinsMarket
        case .historicalMarket(let id, _, _, _):
            return String(format: API.coinsByMarketChart, id)
        case .coinsByIdOhlc(let id, _, _):
            return String(format: API.coinsByIdOhlc, id)
        case .coinsById(let id):
            return String(format: API.coinsById, id)
        }
    }
    
    // MARK: - Constrói e retorna um URLRequest pronto para o URLSession
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: API.baseURL) else {
            throw URLError(.badURL)
        }
        
        var parameters: [String: String] = [:]
        
        switch self {
        case .coinsMarket(let vsCurrency, let cryptocurrencies, let order, let perPage, let page, let percentage):
            parameters = [
                "vs_currency": vsCurrency,
                "order": order,
                "per_page": String(perPage),
                "page": String(page),
                "sparkline": "false",
                "price_change_percentage": percentage
            ]
            if let cryptocurrencies {
                parameters["ids"] = cryptocurrencies.joined(separator: ",")
            }
            
        case .historicalMarket(_, let vsCurrency, let from, let to):
            parameters = [
                "vs_currency": vsCurrency,
                "from": from,
                "to": to
            ]
            
        case .coinsByIdOhlc(_, let currency, let days):
            parameters = [
                "vs_currency": currency,
                "days": days
            ]
            
        case .coinsById:
            parameters = [
                "localization": "false",
                "tickers": "false",
                "market_data": "true"
            ]
        }
        
        guard let fullURL = baseURL.appendingQueryParameters(path: path, parameters: parameters) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        return request
    }
}

// MARK: - Extensão para montar URLs com query parameters
extension URL {
    func appendingQueryParameters(path: String, parameters: [String: String]) -> URL? {
        let completeURL = self.appendingPathComponent(path)
        var components = URLComponents(url: completeURL, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}
