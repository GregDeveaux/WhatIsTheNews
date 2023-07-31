//
//  PageOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 31/07/2023.
//

import SwiftUI

struct PageOfTheNew: View {
    @Environment (\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: HomeViewModel

    var number: Int = 0

    var body: some View {
        AsyncImage(url: URL(string: viewModel.newsSelection[number].urlToImage)) { image in
            image
                .resizable()
                .scaledToFill()
                .grayscale(1)
        } placeholder: {
            ProgressView()
                .background(Color.gray)
        }
        .frame(width: 350, height: 350)
        .clipShape(Rectangle())
        .mask {
            LinearGradient(gradient: Gradient(colors: [.black, .black, .clear, .clear]),
                           startPoint: .top,
                           endPoint: .bottom)
        }
        .blendMode(colorScheme == .light ? .multiply : .exclusion)
        .background {
            ZStack {
                Rectangle()
                    .foregroundColor(.backgroundApp)

                Image("Dots-texture")
                    .resizable()
                    .opacity(colorScheme == .light ? 0.3 : 1)
                    .blendMode(.multiply)
            }
        }
        .overlay(alignment: .bottom) {
            Text(viewModel.newsSelection[number].title)
                .padding(.bottom, 17)
                .padding([.trailing, .leading], 5)
                .font(.system(size: 23))
                .fontDesign(.serif)
                .textCase(.uppercase)
                .foregroundColor(colorScheme == .light ? .black : .white)
        }
    }
}


struct PageOfTheNew_Previews: PreviewProvider {
    static var viewModel = HomeViewModel()

    static var previews: some View {
        PageOfTheNew(number: 0)
            .environmentObject(viewModel)
    }
}
