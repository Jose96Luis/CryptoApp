//
//  ContentView.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cryptoService = CryptoService()
    
    var body: some View {
        NavigationView {
            List(cryptoService.cryptos) { crypto in
                VStack(alignment: .leading) {
                    Text(crypto.name)
                        .font(.headline)
                    Text("Price: \(crypto.priceUsd)")
                    Text("Supply: \(crypto.supply)")
                    Text("Change (24h): \(crypto.changePercent24Hr)%")
                }
            }
            .navigationTitle("Cryptocurrencies")
            .onAppear {
                cryptoService.fetchCryptos()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
