//
//  CurrenciesViewController.swift
//  Feature
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import UIKit

// MARK: - Initialisation

public final class CurrenciesViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIVisualEffectView!
    
    private let viewModel: CurrenciesViewModel
    
    public init(viewModel: CurrenciesViewModel = CurrenciesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View LifeCycle

public extension CurrenciesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.delegate = self
        viewModel.delegate = self
        fetchCoins()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: String(describing: CurrenciesTableViewCell.self), bundle: Bundle.module)
        let reuseIdentifier = String(describing: "\(CurrenciesTableViewCell.self)Identifier")
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.delegate = self
    }

    private func fetchCoins() {
        Task { [viewModel] in
            await viewModel.execute()
        }
    }
}

// MARK: - CurrenciesViewModelelegate

extension CurrenciesViewController: @preconcurrency CurrenciesViewModelDelegate {
    
    func currencies(title: String) {
        self.title = title
    }

    func currencies(dataSource: UITableViewDataSource) {
        loadingView.isHidden.toggle()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func currencies(filteredDataSource: UITableViewDataSource) {
        tableView.dataSource = filteredDataSource
        tableView.reloadData()
    }

    func currencies(error: CustomStringConvertible) {
        loadingView.isHidden.toggle()
        let retry: @Sendable () -> Void = {  [weak self] in
            Task { @MainActor in
                self?.loadingView.isHidden.toggle()
                self?.fetchCoins()
            }
        }
        presentAlert(body: error.description, retry: retry)
    }
}

// MARK: - UITableViewDelegate

extension CurrenciesViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension CurrenciesViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(searchText: searchText)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CurrenciesViewController: AlertPresentable { }
