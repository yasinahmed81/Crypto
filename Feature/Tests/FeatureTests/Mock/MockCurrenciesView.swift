//
//  MockCurrenciesView.swift
//  FeatureTests
//
//  Created by Yasin Ahmed on 09/02/2021.
//

@testable import Feature
import UIKit

final class MockCurrenciesView: CurrenciesViewModelDelegate {
    
    var titleCount = 0
    var title: ((String) -> Void)?
    
    var dataSourceCount = 0
    var dataSource: ((UITableViewDataSource?) -> Void)?
    
    var filteredDataSourceCount = 0
    var filteredDataSource: ((UITableViewDataSource?) -> Void)?
    
    var errorCount = 0
    var error: ((CustomStringConvertible) -> Void)?
    
    func currencies(title: String) {
        titleCount += 1
        self.title?(title)
    }
    
    func currencies(dataSource: UITableViewDataSource) {
        dataSourceCount += 1
        self.dataSource?(dataSource)
    }
    
    func currencies(filteredDataSource: UITableViewDataSource) {
        filteredDataSourceCount += 1
        self.filteredDataSource?(filteredDataSource)
    }
    
    func currencies(error: CustomStringConvertible) {
        errorCount += 1
        self.error?(error)
    }
    
}
