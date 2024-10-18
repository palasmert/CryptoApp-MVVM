//
//  ViewCryptoControllerViewModel.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 17.10.2024.
//

import Foundation
import UIKit

class ViewCryptoControllerViewModel {
        
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - initializer
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    //MARK: computed prop
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: \(self.coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(self.coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "MaxSupply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123"
        }
    }
}
