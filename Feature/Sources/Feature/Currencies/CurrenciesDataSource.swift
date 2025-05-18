//
//  CurrenciesDataSource.swift
//  Crypto
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import UseCase
import UIKit

final class CurrenciesDataSource: NSObject {
    
    private let coins: [Coin]
    
    init(coins: [Coin]) {
        self.coins = coins
    }
    
}

// MARK: - DataSource

extension CurrenciesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "\(CurrenciesTableViewCell.self)Identifier")) as? CurrenciesTableViewCell else {
            assertionFailure("We should have a CurrenciesTableViewCell.")
            return UITableViewCell()
        }
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
}
