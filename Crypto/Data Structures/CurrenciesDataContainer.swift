//
//  CurrenciesDataContainer.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

struct CurrenciesDataContainer: Decodable {
    let status: String
    let data: CurrenciesData
}

struct CurrenciesData: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
    let symbol: String
    let name: String
    let iconUrl: String
    let price: String
    let history: [String]
    
    var pngURL: URL? {
        let url = iconUrl.replacingOccurrences(of: ".svg", with: ".png")
        return URL(string: url)
    }
    
    var currentPrice: String {
        return format(price)
    }
    
    var highestPrice: String {
        guard let highestPrice = history.compactMap({ Double($0) }).sorted().last else { return "" }
        return format(String(highestPrice))
    }
    
    var lowestPrice: String {
        guard let lowestPrice = history.compactMap({ Double($0) }).sorted().first else { return "" }
        return format(String(lowestPrice))
    }
    
    private func format(_ price: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.locale = Locale(identifier: "en_GB")
        guard let amount = Double(price), let formattedPrice = numberFormatter.string(from: NSNumber(value: amount)) else { return price }
        return formattedPrice
    }
    
}
