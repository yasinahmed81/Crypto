//
//  CurrenciesDataSourceTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

import XCTest
@testable import Crypto

final class CurrenciesDataSourceTests: XCTestCase {
    
    var mockCoin: MockCoin!
    var dataSource: UITableViewDataSource!

    override func setUp() {
        super.setUp()
        mockCoin = MockCoin()
        dataSource = CurrenciesDataSource(coins: [mockCoin.bitCoin, mockCoin.ethereum])
    }
    
    override func tearDown() {
        mockCoin = nil
        dataSource = nil
        super.tearDown()
    }
    
    func test_dataSource_shouldHave2Rows() {
        let rows = dataSource.tableView(UITableView(), numberOfRowsInSection: .zero)
        XCTAssertEqual(rows, 2)
    }
    
    func test_dataSource_shouldReturnCurrenciesTableViewCell() {
        let cell = dataSource.tableView(MockTableView(), cellForRowAt: IndexPath(row: .zero, section: .zero))
        XCTAssertTrue(cell is CurrenciesTableViewCell)
    }
    
}
