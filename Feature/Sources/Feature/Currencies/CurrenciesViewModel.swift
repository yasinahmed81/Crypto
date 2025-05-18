//
//  CurrenciesViewModel.swift
//  Feature
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation
import UseCase
import Common
import UIKit

protocol CurrenciesViewModelDelegate: AnyObject {
    func currencies(title: String)
    func currencies(dataSource: UITableViewDataSource)
    func currencies(filteredDataSource: UITableViewDataSource)
    func currencies(error: CustomStringConvertible)
}

@MainActor
public final class CurrenciesViewModel {
    
    weak var delegate: CurrenciesViewModelDelegate?
    
    private var filteredDataSource: CurrenciesDataSource?
    
    private var dataSource: CurrenciesDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            delegate?.currencies(dataSource: dataSource)
        }
    }
    
    private let useCase: any Executable<CurrenciesViewState>
    
    public init(useCase: any Executable<CurrenciesViewState> = CurrenciesUseCase()) {
        self.useCase = useCase
    }
    
    func execute() async {
        provideTitle()
        await fetchCurrencies()
    }
    
    func filter(searchText: String) {
        guard let dataSource = dataSource else { return }
        if searchText.isEmpty {
            delegate?.currencies(filteredDataSource: dataSource)
            return
        }
        let filteredCoins = dataSource.coins.filter { coin in
            coin.name.lowercased().hasPrefix(searchText.lowercased())
        }
        self.filteredDataSource = CurrenciesDataSource(coins: filteredCoins)
        guard let filteredDataSource = self.filteredDataSource else { return }
        delegate?.currencies(filteredDataSource: filteredDataSource)
    }
    
    private func provideTitle() {
        let title = "Currencies"
        delegate?.currencies(title: title)
    }
    
    private func fetchCurrencies() async {
        do {
            let viewState = try await useCase.execute()
            self.dataSource = CurrenciesDataSource(coins: viewState.coins)
        } catch {
            delegate?.currencies(error: error as CustomStringConvertible)
        }
    }
}
