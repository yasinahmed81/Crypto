//
//  CurrenciesMapper.swift
//  UseCase
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Common
import Repository
import Foundation

public final class CurrenciesMapper: Mapping {
    
    public init() {}

    public func map(_ input: CurrenciesEntityContainer) -> CurrenciesViewState {
        CurrenciesViewState(
            status: input.status,
            coins: input.data.coins.map { coinEntity in
                Coin(
                    symbol: coinEntity.symbol,
                    name: coinEntity.name,
                    iconUrl: coinEntity.iconUrl,
                    price: coinEntity.price,
                    sparkline: coinEntity.sparkline,
                    pngURL: coinEntity.pngURL,
                    currentPrice: coinEntity.currentPrice,
                    highestPrice: coinEntity.highestPrice,
                    lowestPrice: coinEntity.lowestPrice
                )
            }
        )
    }
}
