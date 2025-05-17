//
//  CurrenciesEntity.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public struct CurrenciesEntityContainer {
    public let status: String
    public let data: CurrenciesEntity
}

public struct CurrenciesEntity {
    public let coins: [CoinEntity]
}

public struct CoinEntity {
    public let symbol: String
    public let name: String
    public let iconUrl: String
    public let price: String
    public let sparkline: [String?]
    public let pngURL: URL?
    public let currentPrice: String
    public let highestPrice: String
    public let lowestPrice: String
}
