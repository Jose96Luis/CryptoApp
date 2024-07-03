//
//  CryptoService.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation

class CryptoService {
    func fetchCryptos(completion: @escaping ([Crypto]) -> Void) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let cryptoResponse = try JSONDecoder().decode(CryptoResponse.self, from: data)
                    completion(cryptoResponse.data)
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
}
