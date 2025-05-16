//
//  CurrenciesMapperTests.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import Repository
import XCTest

final class CurrenciesMapperTests: XCTestCase {
    
    var mapper: CurrenciesMapper!

    override func setUp() {
        super.setUp()
        mapper = CurrenciesMapper()
    }
    
    override func tearDown() {
        mapper = nil
        super.tearDown()
    }
    
    func test_mapper_mapsDataToEntity() {
        let entity = mapper.map(MockCurrenciesDataContainer.makeContainer())
        let firstCoin = entity.data.coins[0]

        XCTAssertEqual(entity.status, "success")
        XCTAssertEqual(firstCoin.symbol, "GBP")
        XCTAssertEqual(firstCoin.name, "Bitcoin")
        XCTAssertEqual(firstCoin.iconUrl, "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")
        XCTAssertEqual(firstCoin.price, "34247.9280812048")
        XCTAssertEqual(firstCoin.sparkline, [Optional("31122.2328420497"), Optional("31127.1862268281"), nil])
        XCTAssertEqual(firstCoin.pngURL?.absoluteString, "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.png")
        XCTAssertEqual(firstCoin.currentPrice, "£34,247.93")
        XCTAssertEqual(firstCoin.highestPrice, "£31,127.19")
        XCTAssertEqual(firstCoin.lowestPrice, "£31,122.23")
    }
}
