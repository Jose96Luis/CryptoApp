//
//  ContentView.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CryptoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.cryptos.isEmpty {
                    Text("No cryptocurrencies available")
                        .padding()
                } else {
                    ScrollView {
                        ForEach(viewModel.cryptos) { crypto in
                            CryptoCardView(crypto: crypto)
                        }
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
