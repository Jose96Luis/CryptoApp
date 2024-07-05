//
//  CoinGeckoService.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

struct CoinGeckoCrypto: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let market_cap: Double
    let market_cap_rank: Int
    let fully_diluted_valuation: Double?
    let total_volume: Double
    let high_24h: Double
    let low_24h: Double
    let price_change_24h: Double
    let price_change_percentage_24h: Double
    let market_cap_change_24h: Double
    let market_cap_change_percentage_24h: Double
    let circulating_supply: Double
    let total_supply: Double?
    let max_supply: Double?
    let ath: Double
    let ath_change_percentage: Double
    let ath_date: String
    let atl: Double
    let atl_change_percentage: Double
    let atl_date: String
    let roi: Roi?
    let last_updated: String
}

struct Roi: Codable {
    let times: Double
    let currency: String
    let percentage: Double
}

class CoinGeckoService {
    func fetchCryptos() async -> [CoinGeckoCrypto]? {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd") else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            if let cryptos = try? decoder.decode([CoinGeckoCrypto].self, from: data) {
                return cryptos
            } else if let errorResponse = try? decoder.decode([String: String].self, from: data) {
                print("Error response from API: \(errorResponse)")
                return nil
            } else {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Unexpected response format: \(responseString)")
                }
                return nil
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }
}
