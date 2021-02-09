//
//  RequestTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

import XCTest
@testable import Crypto

final class RequestTests: XCTestCase {
    
    var request: URLRequestFactory!

    override func setUp() {
        super.setUp()
        request = Request.cryptoCurrencies
    }
    
    override func tearDown() {
        request = nil
        super.tearDown()
    }
    
    func test_requestURL_isNotNil() {
        XCTAssertNotNil(request.makeRequest.url)
        XCTAssertEqual(request.makeRequest.url, URL(string: "https://api.coinranking.com/v1/public/coins?base=GBP&timePeriod=24h"))
    }
    
}
