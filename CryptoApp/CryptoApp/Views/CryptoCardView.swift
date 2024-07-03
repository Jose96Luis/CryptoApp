//
//  CryptoCardView.swift
//  CryptoApp
//
//  Created by José Rodriguez Romero on 03/07/24.
//

import Foundation
import SwiftUI

struct CryptoCardView: View {
    var crypto: CryptoViewModelItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(crypto.name)
                .font(.headline)
            Text("Price: \(crypto.priceUsd)")
            Text("Supply: \(crypto.supply)")
            Text("Change (24h): \(crypto.changePercent24Hr)%")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding([.top, .horizontal])
    }
}
