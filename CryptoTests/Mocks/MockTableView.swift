//
//  MockTableView.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

@testable import Crypto
import UIKit

final class MockTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        let nib = UINib(nibName: String(describing: CurrenciesTableViewCell.self), bundle: nil)
        let reuseIdentifier = String(describing: "\(CurrenciesTableViewCell.self)Identifier")
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
