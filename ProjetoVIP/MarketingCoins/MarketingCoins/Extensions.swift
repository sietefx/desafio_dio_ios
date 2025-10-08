//
//  Extensions.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation

extension URL {
    // Extract query parameters from the URL into a dictionary
    var queryParameters: [String: String]? {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = urlComponents.queryItems else { return nil }

        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }

    // Build a new URL by optionally appending a path component and query parameters
    func appendingQueryParameters(path: String? = nil, parameters: [String: String]? = nil) -> URL? {
        // Start from self
        var baseURL = self
        if let path = path, !path.isEmpty {
            baseURL = baseURL.appendingPathComponent(path)
        }

        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }

        if let parameters = parameters, !parameters.isEmpty {
            let existing = components.queryItems ?? []
            let additions = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            components.queryItems = existing + additions
        }

        return components.url
    }
}

extension Error {
    
    var errorCode: Int? {
        retur (selfas NSError).code
    }
}
