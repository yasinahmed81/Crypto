//
//  RequestTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

import XCTest
@testable import Crypto

final class RequestTests: XCTestCase {
    
    var request: URLRequest!

    override func setUp() {
        super.setUp()
        request = Request.cryptoCurrencies.makeRequest
    }
    
    override func tearDown() {
        request = nil
        super.tearDown()
    }
    
    func test_requestURL_isNotNil() {
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url, URL(string: "https://api.coinranking.com/v2/coins?base=GBP&timePeriod=24h"))
    }
    
}
