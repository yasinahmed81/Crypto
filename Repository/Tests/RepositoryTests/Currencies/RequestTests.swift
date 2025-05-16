//
//  RequestTests.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

@testable import Repository
import XCTest

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
