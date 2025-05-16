//
//  CurrenciesMapper.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Common
import Foundation

public final class CurrenciesMapper: Mapping {
    
    public init() {}

    public func map(_ input: CurrenciesDataContainer) -> CurrenciesEntityContainer {
        CurrenciesEntityContainer(
            status: input.status,
            data: CurrenciesEntity(
                coins: input.data.coins.map { coinData in
                    CoinEntity(
                        symbol: coinData.symbol,
                        name: coinData.name,
                        iconUrl: coinData.iconUrl,
                        price: coinData.price,
                        sparkline: coinData.sparkline,
                        pngURL: makePNRUrl(iconUrl: coinData.iconUrl),
                        currentPrice: makeCurrentPrice(price: coinData.price),
                        highestPrice: makeHighestPrice(sparkline: coinData.sparkline),
                        lowestPrice: makeLowestPrice(sparkline: coinData.sparkline)
                    )
                }
            )
        )
    }
    
    private func makePNRUrl(iconUrl: String) -> URL? {
        let url = iconUrl.replacingOccurrences(of: ".svg", with: ".png")
        return URL(string: url)
    }
    
    private func makeCurrentPrice(price: String) -> String {
        return format(price)
    }
    
    private func makeHighestPrice(sparkline: [String?]) -> String {
        let sortedHistory = getSortedHistory(sparkline: sparkline)
        guard let highestPrice = sortedHistory.last else { return "" }
        return format(String(highestPrice))
    }
    
    private func makeLowestPrice(sparkline: [String?]) -> String {
        let sortedHistory = getSortedHistory(sparkline: sparkline)
        guard let lowestPrice = sortedHistory.first else { return "" }
        return format(String(lowestPrice))
    }
    
    private func getSortedHistory(sparkline: [String?]) -> [Double] {
        return sparkline.compactMap({ Double($0 ?? "") }).sorted()
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
