//
//  MockCoin.swift
//  FeatureTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

import Foundation
@testable import UseCase

struct MockCoin {
    let bitCoin = Coin(
        symbol: "BTC",
        name: "Bitcoin",
        iconUrl: "https://bitcoin.com",
        price: "100.123456",
        sparkline: ["300.00", "200.00", "400.00"],
        pngURL: URL(string: "https://bitcoin.com"),
        currentPrice: "200.00",
        highestPrice: "300.00",
        lowestPrice: "100.00"
    )
    let ethereum = Coin(
        symbol: "ETH",
        name: "Ethereum",
        iconUrl: "https://ethereum.com",
        price: "200.98765",
        sparkline: ["500.00", "400.00", "300.00"],
        pngURL: URL(string: "https://ethereum.com"),
        currentPrice: "200.00",
        highestPrice: "300.00",
        lowestPrice: "100.00"
    )
}

