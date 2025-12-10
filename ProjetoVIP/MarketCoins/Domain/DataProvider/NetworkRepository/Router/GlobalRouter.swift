//
//  GlobalRouters.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

enum GlobalRouter {
    
    case global
    
    var path: String {
        switch self {
        case .global:
            return API.global
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: API.baseURL) else {
            throw NSError(domain: "InvalidBaseURL", code: 0, userInfo: nil)
        }

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
