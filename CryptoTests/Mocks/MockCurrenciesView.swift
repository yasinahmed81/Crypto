//
//  MockCurrenciesView.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 09/02/2021.
//

@testable import Crypto
import UIKit

final class MockCurrenciesView: CurrenciesPresenterDelegate {
    
    var titleCount = 0
    var title: ((String) -> Void)?
    
    var dataSourceCount = 0
    var dataSource: ((UITableViewDataSource?) -> Void)?
    
    var errorCount = 0
    var error: ((CustomStringConvertible, _ retryFetchingCurrencies: () -> Void) -> Void)?
    
    func currencies(_ presenter: CurrenciesPresenter, didProvide title: String) {
        titleCount += 1
        self.title?(title)
    }
    
    func currencies(_ presenter: CurrenciesPresenter, didProvide dataSource: UITableViewDataSource) {
        dataSourceCount += 1
        self.dataSource?(dataSource)
    }
    
    func currencies(_ presenter: CurrenciesPresenter, didProvide error: CustomStringConvertible, retryFetchingCurrencies: @escaping () -> Void) {
        errorCount += 1
        self.error?(error, retryFetchingCurrencies)
    }
    
}
