//
//  MockCoin.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

@testable import Crypto

struct MockCoin {
    let bitCoin = Coin(symbol: "BTC", name: "Bitcoin", iconUrl: "https://bitcoin.com", price: "100.123456", history: ["300.00", "200.00", "400.00"])
    let ethereum = Coin(symbol: "ETH", name: "Ethereum", iconUrl: "https://ethereum.com", price: "200.98765", history: ["500.00", "400.00", "300.00"])
}

