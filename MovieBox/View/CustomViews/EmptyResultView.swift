//
//  EmptyResultView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import SwiftUI

struct EmptyResultView: View {
    let imageName: String
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "movieclapper")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.main)
                .opacity(0.7)
                .padding(.top, 15)
                .padding()


            Text(message)
                .font(Fonts.Subtitle.mediumSemibold)
                .foregroundColor(Color.primaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyResultView(imageName: "movie", message: "There is no movies")
}
