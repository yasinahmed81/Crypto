//
//  CurrenciesEntity.swift
//  UseCase
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public struct CurrenciesViewState {
    let status: String
    let coins: [Coin]
}

public struct Coin {
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
