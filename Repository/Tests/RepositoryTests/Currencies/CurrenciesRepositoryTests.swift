//
//  CurrenciesRepositoryTests.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import Repository
@testable import Core
import XCTest

final class CurrenciesRepositoryTests: XCTestCase {
    
    func test_repositoryReturnsEntity_successfully() async throws {
        let repository = CurrenciesRepository(service: MockHttpClient(condition: .success))
        let entity = try await repository.execute()
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
    
    func test_repositoryThrowsError() async throws {
        let repository = CurrenciesRepository(service: MockHttpClient(condition: .error))
        let expectation = expectation(description: "Repository throws")
        
        do {
            _ = try await repository.execute()
        } catch {
            if let error = error as? Core.HttpClientError {
                XCTAssertEqual(error.description, "There was an unexpected response from the network request.")
                expectation.fulfill()
            }
        }
     
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
