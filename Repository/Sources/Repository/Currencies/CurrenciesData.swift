//
//  CurrenciesDataContainer.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public struct CurrenciesDataContainer: Decodable {
    let status: String
    let data: CurrenciesData
}

struct CurrenciesData: Decodable {
    let coins: [CoinData]
}

struct CoinData: Decodable {
    let symbol: String
    let name: String
    let iconUrl: String
    let price: String
    let sparkline: [String?]
}
