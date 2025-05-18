//
//  MockViewState.swift
//  UseCase
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import UseCase
import Foundation

struct MockCurrenciesViewState {
    static func makeState() -> CurrenciesViewState {
        CurrenciesViewState(
            status: "success",
            coins: [
                Coin(
                    symbol: "GBP",
                    name: "Bitcoin",
                    iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
                    price: "34247.9280812048",
                    sparkline: [
                        "31122.2328420497",
                        "31127.1862268281"
                    ],
                    pngURL: URL(string: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.png"),
                    currentPrice: "£34,247.93",
                    highestPrice: "£31,127.19",
                    lowestPrice: "£31,122.23"
                )
            ]
        )
    }
}
