//
//  CryptoStorage.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 04/07/24.
//

import Foundation

struct CryptoStorage: Codable {
    let id: String
    let image: String
    let current_price: Double
    let circulating_supply: Double
    let price_change_percentage_24h: Double
}

extension CoinGeckoCrypto {
    func toCryptoStorage() -> CryptoStorage {
        return CryptoStorage(
            id: id,
            image: image,
            current_price: current_price,
            circulating_supply: circulating_supply,
            price_change_percentage_24h: price_change_percentage_24h
        )
    }
}

extension CryptoStorage {
    func toCoinGeckoCrypto() -> CoinGeckoCrypto? {
        return CoinGeckoCrypto(
            id: id,
            symbol: "",
            name: "",
            image: image,
            current_price: current_price,
            market_cap: 0,
            market_cap_rank: 0,
            fully_diluted_valuation: nil,
            total_volume: 0,
            high_24h: 0,
            low_24h: 0,
            price_change_24h: 0,
            price_change_percentage_24h: price_change_percentage_24h,
            market_cap_change_24h: 0,
            market_cap_change_percentage_24h: 0,
            circulating_supply: circulating_supply,
            total_supply: nil,
            max_supply: nil,
            ath: 0,
            ath_change_percentage: 0,
            ath_date: "",
            atl: 0,
            atl_change_percentage: 0,
            atl_date: "",
            roi: nil,
            last_updated: ""
        )
    }
}
