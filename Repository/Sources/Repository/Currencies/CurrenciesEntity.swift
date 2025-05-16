//
//  CurrenciesEntity.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public struct CurrenciesEntityContainer {
    let status: String
    let data: CurrenciesEntity
}

public struct CurrenciesEntity {
    let coins: [CoinEntity]
}

public struct CoinEntity {
    let symbol: String
    let name: String
    let iconUrl: String
    let price: String
    let sparkline: [String?]
    let pngURL: URL?
    let currentPrice: String
    let highestPrice: String
    let lowestPrice: String
}
