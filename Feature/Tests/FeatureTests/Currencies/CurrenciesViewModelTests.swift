//
//  CurrenciesViewModelTests.swift
//  FeatureTests
//
//  Created by Yasin Ahmed on 09/02/2021.
//

import XCTest
@testable import Feature

@MainActor
final class CurrenciesViewModelTests: XCTestCase {
    
    func test_viewModel_didProvideTitle() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .success))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "Title expectation")
        
        mockView.title = { title in
            XCTAssertEqual(title, "Currencies")
            XCTAssertEqual(mockView.titleCount, 1)
            expectation.fulfill()
        }
        XCTAssertEqual(mockView.titleCount, 0)
        await viewModel.execute()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_viewModel_didProvideDataSource() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .success))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "DataSource expectation")
        
        mockView.dataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(mockView.dataSourceCount, 1)
            expectation.fulfill()
        }
        XCTAssertEqual(mockView.dataSourceCount, 0)
        await viewModel.execute()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_viewModel_didProvideFilteredDataSource_whenSearchMatched() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .success))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "Matched filteredDataSource expectation")
        
        mockView.filteredDataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(mockView.filteredDataSourceCount, 1)
            expectation.fulfill()
        }
        XCTAssertEqual(mockView.filteredDataSourceCount, 0)
        await viewModel.execute()
        
        viewModel.filter(searchText: "Bitcoin")
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_viewModel_didProvideOriginalDataSource_whenSearchIsEmpty() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .success))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "SearchIsEmpty expectation")
        
        mockView.filteredDataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(mockView.filteredDataSourceCount, 1)
            expectation.fulfill()
        }
        XCTAssertEqual(mockView.filteredDataSourceCount, 0)
        await viewModel.execute()
        
        viewModel.filter(searchText: "")
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_viewModel_didProvideFilteredDataSource_whenSearchNotMatched() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .success))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "Unmatched filteredDataSource expectation")
        
        mockView.filteredDataSource = { dataSource in
            XCTAssertNotNil(dataSource)
            XCTAssertEqual(mockView.filteredDataSourceCount, 1)
            if let dataSource = dataSource as? CurrenciesDataSource {
                XCTAssertEqual(dataSource.coins.count, 0)
                expectation.fulfill()
            }
        }
        XCTAssertEqual(mockView.filteredDataSourceCount, 0)
        await viewModel.execute()
        
        viewModel.filter(searchText: "SomeCoin")
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_viewModel_didProvideError() async {
        let viewModel = CurrenciesViewModel(useCase: MockCurrenciesUseCase(condition: .error))
        let mockView = MockCurrenciesView()
        viewModel.delegate = mockView
        
        let expectation = expectation(description: "Error expectation")
        
        mockView.error = { error in
            XCTAssertEqual(error.description, "FeatureTests.UnknownError.any")
            XCTAssertEqual(mockView.errorCount, 1)
            XCTAssertEqual(mockView.dataSourceCount, 0)
            expectation.fulfill()
        }
        XCTAssertEqual(mockView.errorCount, 0)
        await viewModel.execute()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
