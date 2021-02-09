//
//  NetworkServiceTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

import XCTest
@testable import Crypto

final class NetworkServiceTests: XCTestCase {
    
    var mockURLSession: MockURLSession!
    var networkService: Resourcable!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkService = NetworkService(session: mockURLSession, shouldExecuteCallbackOnMainThread: false)
    }
    
    override func tearDown() {
        mockURLSession = nil
        networkService = nil
        super.tearDown()
    }
    
    func test_networkService_decodingModelParsesSuccessfully() {
        mockURLSession.makeCoinsData()
        mockURLSession.makeExpectedResponse()
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success(let container):
                let coins = container.data.coins
                XCTAssertEqual(coins[0].name, "Bitcoin")
                XCTAssertEqual(coins[1].iconUrl, "https://cdn.coinranking.com/rk4RKHOuW/eth.svg")
                XCTAssertEqual(coins[2].symbol, "USDT")
                XCTAssertEqual(coins[3].price, "16.79335847")
            case .failure:
                XCTFail("The test should hit the success case above.")
            }
        }
    }
    
    func test_networkService_didReceiveURLError() {
        mockURLSession.makeError()
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success:
                XCTFail("The test should hit the failure case below.")
            case .failure(let error):
                if case .urlError = error {
                    XCTAssertEqual(error.description, "There was an error in the network request.\nReason: The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")
                } else {
                    XCTFail("The error should be a urlError.")
                }
            }
        }
    }
    
    func test_networkService_didReceiveNoResponseError() {
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success:
                XCTFail("The test should hit the failure case below.")
            case .failure(let error):
                if case .noResponseReceived = error {
                    XCTAssertEqual(error.description, "There was no response received from the network request.")
                } else {
                    XCTFail("The error should be noResponseReceived.")
                }
            }
        }
    }
    
    func test_networkService_didReceiveNoDataError() {
        mockURLSession.makeExpectedResponse()
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success:
                XCTFail("The test should hit the failure case below.")
            case .failure(let error):
                if case .noDataReceived = error {
                    XCTAssertEqual(error.description, "There was no data received from the network request.")
                } else {
                    XCTFail("The error should be noDataReceived.")
                }
            }
        }
    }
    
    func test_networkService_didReceiveDecodingError() {
        mockURLSession.makeCorruptData()
        mockURLSession.makeExpectedResponse()
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success:
                XCTFail("The test should hit the failure case below.")
            case .failure(let error):
                if case .decodingFailure = error {
                    XCTAssertEqual(error.description, "The data received from the network request could not be decoded.\nReason: The data couldn’t be read because it isn’t in the correct format.")
                } else {
                    XCTFail("The error should be a decodingFailure.")
                }
            }
        }
    }
    
    func test_networkService_didReceiveUnexpectedError() {
        mockURLSession.makeCoinsData()
        mockURLSession.makeUnexpectedResponse()
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { result in
            switch result {
            case .success:
                XCTFail("The test should hit the failure case below.")
            case .failure(let error):
                if case .unexpectedResponse = error {
                    XCTAssertEqual(error.description, "There was an unexpected response from the network request.\nReason: HTTP status code was 404.")
                } else {
                    XCTFail("The error should be an unexpectedResponse.")
                }
            }
        }
    }
    
}
