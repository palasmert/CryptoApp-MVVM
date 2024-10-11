//
//  Coin.swift
//  CryptoAppMVVM
//
//  Created by mert palas on 11.10.2024.
//

import Foundation

struct Coin {
    
    let id: Int
    let name : String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    struct Quote {
        let CAD: CAD
        
        struct CAD {
            let price: Double
            let market_cap: Double
        }
    }
}

extension Coin {
    public static func getMockArray() -> [Coin] {
        return [
        Coin(id: 1, name: "Bitcoin", max_supply: 200, cmc_rank: 1, quote: Quote(CAD: Quote.CAD(price: 5000, market_cap: 1_000_000))),
        Coin(id: 2, name: "Ethereum", max_supply: nil, cmc_rank: 2, quote: Quote(CAD: Quote.CAD(price: 1000, market_cap: 500_000))),
        Coin(id: 3, name: "Monero", max_supply: nil, cmc_rank: 3, quote: Quote(CAD: Quote.CAD(price: 300, market_cap: 100000)))
        ]
    }
}


