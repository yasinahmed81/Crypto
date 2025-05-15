//
//  CurrenciesViewController.swift
//  Crypto
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import UIKit

// MARK: - Initialisation

final class CurrenciesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIVisualEffectView!
    
    private let presenter: CurrenciesPresentable
    
    init(presenter: CurrenciesPresentable = CurrenciesPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View LifeCycle

extension CurrenciesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.delegate = self
        presenter.execute()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: String(describing: CurrenciesTableViewCell.self), bundle: nil)
        let reuseIdentifier = String(describing: "\(CurrenciesTableViewCell.self)Identifier")
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.delegate = self
    }

}

// MARK: - CurrenciesPresenterDelegate

extension CurrenciesViewController: CurrenciesPresenterDelegate {

    func currencies(_ presenter: CurrenciesPresenter, didProvide title: String) {
        self.title = title
    }

    func currencies(_ presenter: CurrenciesPresenter, didProvide dataSource: UITableViewDataSource) {
        loadingView.isHidden.toggle()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    func currencies(_ presenter: CurrenciesPresenter, didProvide error: CustomStringConvertible, retryFetchingCurrencies: @escaping () -> Void) {
        loadingView.isHidden.toggle()
        let retry = { [weak self, retryFetchingCurrencies] in
            self?.loadingView.isHidden.toggle()
            retryFetchingCurrencies()
        }
        presentAlert(body: error.description, retry: retry)
    }

}

// MARK: - UITableViewDelegate

extension CurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CurrenciesViewController: AlertPresentable { }
