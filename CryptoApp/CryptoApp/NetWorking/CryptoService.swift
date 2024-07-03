//
//  CryptoService.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

class CryptoService: ObservableObject {
    @Published var cryptos = [Crypto]() {
        didSet {
            saveCryptos()
        }
    }
    
    init() {
        loadCryptos()
    }
    //Consumo del API
    func fetchCryptos() {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let cryptoResponse = try JSONDecoder().decode(CryptoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.cryptos = cryptoResponse.data
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
    //Guardamos la información
    private func saveCryptos() {
        if let encoded = try? JSONEncoder().encode(cryptos) {
            UserDefaults.standard.set(encoded, forKey: "cryptos")
        }
    }
    
    private func loadCryptos() {
        if let savedCryptos = UserDefaults.standard.data(forKey: "cryptos") {
            if let decodedCryptos = try? JSONDecoder().decode([Crypto].self, from: savedCryptos) {
                cryptos = decodedCryptos
            }
        }
    }
}

