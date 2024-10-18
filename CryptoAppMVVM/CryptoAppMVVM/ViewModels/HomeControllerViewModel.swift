//
//  HomeControllerViewModel.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 18.10.2024.
//

import Foundation
import UIKit

class HomeControllerViewModel {
 
    var onCoinsUpdated: (()-> Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = []
        
    init() {
        self.fetchCoins()
        
    }
    
    public func fetchCoins() {
        let endPoint = EndPoint.fetchCoins()
        
        CoinService.fetchCoin(with: endPoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case.failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}

//MARK: Search func

extension HomeControllerViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            
            self.filteredCoins = allCoins
            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
            
            self.onCoinsUpdated?()
        }
    }
}
