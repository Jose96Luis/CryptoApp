//
//  CryptoModel.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

struct CryptoResponse: Codable {
    let data: [Crypto]
}
//Modelo de datos
struct Crypto: Codable, Identifiable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let priceUsd: String
    let changePercent24Hr: String
}
