//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos = [CryptoViewModelItem]()
    
    private var cryptoService = CryptoService()
    
    init() {
        fetchCryptos()
    }
    
    func fetchCryptos() {
        cryptoService.fetchCryptos { cryptos in
            DispatchQueue.main.async {
                self.cryptos = cryptos.map(CryptoViewModelItem.init)
            }
        }
    }
}

struct CryptoViewModelItem: Identifiable {
    private var crypto: Crypto
    
    init(crypto: Crypto) {
        self.crypto = crypto
    }
    
    var id: String {
        return crypto.id
    }
    
    var name: String {
        return crypto.name
    }
    
    var priceUsd: String {
        return crypto.priceUsd
    }
    
    var supply: String {
        return crypto.supply
    }
    
    var changePercent24Hr: String {
        return crypto.changePercent24Hr
    }
}
