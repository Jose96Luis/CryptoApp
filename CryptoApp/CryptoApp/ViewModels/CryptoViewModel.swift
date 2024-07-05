//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos = [CoinGeckoCrypto]()
    @Published var isLoading = true
    @Published var errorMessage: String? = nil
    
    private var coinGeckoService = CoinGeckoService()
    
    init() {
        fetchCryptos()
    }
    
    func fetchCryptos() {
        isLoading = true
        errorMessage = nil
        
        coinGeckoService.fetchCryptos { cryptos in
            DispatchQueue.main.async {
                self.isLoading = false
                if let cryptos = cryptos {
                    self.cryptos = cryptos
                } else {
                    self.cryptos = []
                    self.errorMessage = "Failed to load cryptos"
                }
            }
        }
    }
}
