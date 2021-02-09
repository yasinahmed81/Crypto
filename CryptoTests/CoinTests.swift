//
//  CoinTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import XCTest
@testable import Crypto

final class CoinTests: XCTestCase {
    
    var mockCoin: MockCoin!

    override func setUp() {
        super.setUp()
        mockCoin = MockCoin()
    }
    
    override func tearDown() {
        mockCoin = nil
        super.tearDown()
    }
    
    func test_currentPrice_isFormatted() {
        XCTAssertEqual(mockCoin.bitCoin.currentPrice, "£100.12")
    }
    
    func test_highestPrice_shouldBe400Pounds() {
        XCTAssertEqual(mockCoin.bitCoin.highestPrice, "£400.00")
    }
    
    func test_lowestPrice_shouldBe200Pounds() {
        XCTAssertEqual(mockCoin.bitCoin.lowestPrice, "£200.00")
    }
    
}
