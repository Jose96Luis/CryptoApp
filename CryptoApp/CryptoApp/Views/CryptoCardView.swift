//
//  CryptoCardView.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import SwiftUI

struct CryptoCardView: View {
    var crypto: CoinGeckoCrypto
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Imagen de la criptomoneda y nombre
            VStack {
                if let imageUrl = URL(string: crypto.image) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 80)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        @unknown default:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        }
                    }
                } else {
                    Text("No Image Available")
                        .frame(width: 80, height: 80)
                }
                // Nombre de la moneda
                Text(crypto.name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            //.padding(.leading, 16)
            // Padding de 16 puntos a la izquierda de la imagen y el nombre
            // Detalles de la moneda
            VStack(alignment: .leading, spacing: 8) {
                Text("Price: \(crypto.current_price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Supply: \(crypto.circulating_supply, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Change (24h): \(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
            }
            .padding(.horizontal, 32) // Espaciado interno para el VStack
        }
        .padding(16) // Espaciado interno de la tarjeta principal
        .frame(maxWidth: .infinity, minHeight: 120) // Fijar tamaño de la tarjeta
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal, 16) 
        // Padding exterior de 16 puntos a los lados izquierdo y derecho de la tarjeta principal
        .padding(.top, 12) // Padding superior
    }
}

struct CryptoCardView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCardView(crypto: CoinGeckoCrypto(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            current_price: 30000,
            market_cap: 600000000,
            market_cap_rank: 1,
            fully_diluted_valuation: nil,
            total_volume: 50000000,
            high_24h: 32000,
            low_24h: 29000,
            price_change_24h: 500,
            price_change_percentage_24h: 1.5,
            market_cap_change_24h: 10000000,
            market_cap_change_percentage_24h: 1.67,
            circulating_supply: 19000000,
            total_supply: 21000000,
            max_supply: 21000000,
            ath: 69000,
            ath_change_percentage: -56.5,
            ath_date: "2021-11-10T14:24:11.849Z",
            atl: 67.81,
            atl_change_percentage: 44183.0,
            atl_date: "2013-07-06T00:00:00.000Z",
            roi: nil,
            last_updated: "2023-07-04T14:24:11.849Z"
        ))
            .previewLayout(.sizeThatFits)
    }
}
