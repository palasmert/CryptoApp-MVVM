//
//  HomeControllerViewModel.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 18.10.2024.
//

import Foundation

class HomeControllerViewModel {
 
    var onCoinsUpdated: (()-> Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
        
    init() {
        self.fetchCoins()
      //  self.coins.insert(Coin(id: <#T##Int#>, name: <#T##String#>, maxSupply: <#T##Int?#>, rank: <#T##Int#>, pricingData: <#T##PricingData#>), at: <#T##Int#> )
    }
    
    public func fetchCoins() {
        let endPoint = EndPoint.fetchCoins()
        
        CoinService.fetchCoin(with: endPoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
                
            case.failure(let error):
                self?.onErrorMessage?(error)
            }
        }
        
    }
    
}
