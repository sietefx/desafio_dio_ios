//
//  Extensions.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import Foundation
import UIKit

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
        return (self as NSError).code
    }
}

extension Double {
    
    func toCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt-BR")
        
        guard let value = numberFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        return value
    }
    
    func toPercentage() -> String {
        let value = String(format: "%.2f", self).replacingOccurrences(of: "-", with: "")
        
        if self.sign == .minus {
            return "\u{2193} \(value)%"
        } else {
            return "\u{2191} \(value)%" 
        }
    }
}

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        loadImage(from: url)
    }

    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
