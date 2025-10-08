//
//  CryptocurrenciesError.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 03/11/25.
//

import Foundation

enum CryptocurrenciesError: Error {
    case internalServerError
    case badRequestError
    case notFoundError
    case undefinedError
    
    var errorDescription: String {
        switch self {
        case .internalServerError:
            return "Ocorreu um erro no servidor. Tente novamente mais tarde."
        case .badRequestError:
            return "Sua requisição não foi aceita. Tente novamente."
        case .notFoundError:
            return "O servidor não encontrou o que você pediu. Tente novamente."
        case .undefinedError:
            return "Ocorreu um erro. Tente novamente mais tarde."
        }
    }
}
