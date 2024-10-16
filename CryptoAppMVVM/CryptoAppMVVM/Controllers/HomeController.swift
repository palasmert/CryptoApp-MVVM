//
//  ViewController.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 11.10.2024.
//

import UIKit

class HomeController: UIViewController {
    
    
    //MARK: - Variables
    
    private let  viewModel: HomeControllerViewModel
    
    //MARK: - UIComp
    private var searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground  
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    //MARK: - LifeCycle

    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearcController()
        self.setupUI()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                    
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                self?.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    //MARK: - UISETUP
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "CrytoApp-MVVM"
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        
    }
    
    private func setupSearcController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Cryptos"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: search contr func

extension HomeController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    func searchBarBookMarkButtonClicked(_ searchBar: UISearchBar) {
        print("Search Bar Button Called!")
    }
}
//MARK: - TableView func

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.allCoins.count
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable dequeue coincell in homecontr")
        }
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)


        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] :
        self.viewModel.allCoins[indexPath.row]
        
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
        
        
        let vm = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
