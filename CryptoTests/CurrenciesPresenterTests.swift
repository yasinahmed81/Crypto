//
//  CurrenciesPresenterTests.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 09/02/2021.
//

import XCTest
@testable import Crypto

final class CurrenciesPresenterTests: XCTestCase {
    
    var mockURLSession: MockURLSession!
    var mockView: MockCurrenciesView!
    var presenter: CurrenciesPresentable!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        let networkService = NetworkService(session: mockURLSession, shouldExecuteCallbackOnMainThread: false)
        presenter = CurrenciesPresenter(networkService: networkService)
        mockView = MockCurrenciesView()
        presenter.delegate = mockView
    }
    
    override func tearDown() {
        mockURLSession = nil
        mockView = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_presenter_didProvideTitle() {
        mockView.title = { title in
            XCTAssertEqual(title, "Currencies")
            XCTAssertEqual(self.mockView.titleCount, 1)
        }
        XCTAssertEqual(self.mockView.titleCount, 0)
        presenter.execute()
    }
    
    func test_presenter_didProvideDataSource() {
        mockView.dataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(self.mockView.dataSourceCount, 1)
        }
        XCTAssertEqual(mockView.dataSourceCount, 0)
        mockURLSession.makeCoinsData()
        mockURLSession.makeExpectedResponse()
        presenter.execute()
    }
    
    func test_presenter_didProvideError_uponRetry_providesDataSource() {
        mockView.error = { error, retryFetchingCurrencies in
            XCTAssertEqual(error.description, "There was no response received from the network request.")
            XCTAssertEqual(self.mockView.errorCount, 1)
            XCTAssertEqual(self.mockView.dataSourceCount, 0)
            self.mockURLSession.makeCoinsData()
            self.mockURLSession.makeExpectedResponse()
            retryFetchingCurrencies()
        }
        mockView.dataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(self.mockView.dataSourceCount, 1)
        }
        XCTAssertEqual(self.mockView.errorCount, 0)
        presenter.execute()
    }
    
}
