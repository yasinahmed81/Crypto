//
//  MockCurrenciesDataContainer.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import Repository

struct MockCurrenciesDataContainer {
    static func makeContainer() -> CurrenciesDataContainer {
        CurrenciesDataContainer(
            status: "success",
            data: CurrenciesData(
                coins: [
                    CoinData(
                        symbol: "GBP",
                        name: "Bitcoin",
                        iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
                        price: "34247.9280812048",
                        sparkline: [
                            "31122.2328420497",
                            "31127.1862268281",
                            nil
                        ]
                    )
                ]
            )
        )
    }
}
