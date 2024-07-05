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
    private let userDefaultsKey = "cryptos"

    init() {
        loadCryptosFromUserDefaults()
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
                    self.saveCryptosToUserDefaults(cryptos)
                } else {
                    self.cryptos = []
                    self.errorMessage = "Failed to load cryptos"
                }
            }
        }
    }

    private func saveCryptosToUserDefaults(_ cryptos: [CoinGeckoCrypto]) {
        let cryptoStorages = cryptos.map { $0.toCryptoStorage() }
        if let encoded = try? JSONEncoder().encode(cryptoStorages) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            print("Saved cryptos to UserDefaults: \(cryptoStorages)")
        } else {
            print("Failed to encode cryptos for UserDefaults")
        }
    }

    private func loadCryptosFromUserDefaults() {
        guard let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
              let savedCryptos = try? JSONDecoder().decode([CryptoStorage].self, from: savedData) else {
            print("No cryptos found in UserDefaults")
            return
        }
        self.cryptos = savedCryptos.compactMap { $0.toCoinGeckoCrypto() }
        print("Loaded cryptos from UserDefaults: \(savedCryptos)")
    }
}
