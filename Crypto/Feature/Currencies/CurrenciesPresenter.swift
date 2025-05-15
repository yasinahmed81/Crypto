//
//  CurrenciesPresenter.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation
import UIKit

protocol CurrenciesPresenterDelegate: AnyObject {
    func currencies(_ presenter: CurrenciesPresenter, didProvide title: String)
    func currencies(_ presenter: CurrenciesPresenter, didProvide dataSource: UITableViewDataSource)
    func currencies(_ presenter: CurrenciesPresenter, didProvide error: CustomStringConvertible, retryFetchingCurrencies: @escaping () -> Void)
}

protocol CurrenciesPresentable: AnyObject, Executable {
    var delegate: CurrenciesPresenterDelegate? { get set }
}

final class CurrenciesPresenter: CurrenciesPresentable {
    
    weak var delegate: CurrenciesPresenterDelegate?
    
    private var dataSource: UITableViewDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            delegate?.currencies(self, didProvide: dataSource)
        }
    }
    
    private let networkService: Resourcable
    
    init(networkService: Resourcable = NetworkService()) {
        self.networkService = networkService
    }
    
    func execute() {
        provideTitle()
        fetchCurrencies()
    }
    
    private func provideTitle() {
        let title = "Currencies"
        delegate?.currencies(self, didProvide: title)
    }
    
    private func fetchCurrencies() {
        networkService.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let container):
                self.dataSource = CurrenciesDataSource(coins: container.data.coins)
            case .failure(let error):
                self.delegate?.currencies(self, didProvide: error, retryFetchingCurrencies: self.fetchCurrencies)
            }
        }
    }
    
}
