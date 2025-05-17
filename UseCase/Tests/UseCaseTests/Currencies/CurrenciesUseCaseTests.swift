//
//  CurrenciesUseCaseTests.swift
//  UseCase
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import UseCase
import XCTest

final class CurrenciesUseCaseTests: XCTestCase {
    
    func test_useCaseReturnsViewState_successfully() async throws {
        let useCase = CurrenciesUseCase(repository: MockCurrenciesRepository(condition: .success))
        let viewState = try await useCase.execute()
        let firstCoin = viewState.coins[0]
        
        XCTAssertEqual(viewState.status, "success")
        XCTAssertEqual(firstCoin.symbol, "GBP")
        XCTAssertEqual(firstCoin.name, "Bitcoin")
        XCTAssertEqual(firstCoin.iconUrl, "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")
        XCTAssertEqual(firstCoin.price, "34247.9280812048")
        XCTAssertEqual(firstCoin.sparkline, [Optional("31122.2328420497"), Optional("31127.1862268281")])
        XCTAssertEqual(firstCoin.pngURL?.absoluteString, "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.png")
        XCTAssertEqual(firstCoin.currentPrice, "£34,247.93")
        XCTAssertEqual(firstCoin.highestPrice, "£31,127.19")
        XCTAssertEqual(firstCoin.lowestPrice, "£31,122.23")
    }
    
    func test_useCaseThrowsError() async throws {
        let useCase = CurrenciesUseCase(repository: MockCurrenciesRepository(condition: .error))
        let expectation = expectation(description: "UseCase throws")
        
        do {
            _ = try await useCase.execute()
        } catch {
            if let error = error as? UnknownError {
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (UseCaseTests.UnknownError error 0.)")
                expectation.fulfill()
            }
        }
     
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
