//
//  SelectionCarouselOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 31/07/2023.
//

import SwiftUI

struct SelectionCarouselOfTheNew: View {

        // MARK: - property wrappers

    @Environment (\.colorScheme) var colorScheme


        // MARK: - property

    var newsSelection: [New]
    var number: Int
    var width: CGFloat
    var height: CGFloat


        // MARK: - body

    var body: some View {
        if let urlToImage = newsSelection[number].urlToImage {
                // allows create a square image with dot effect
            AsyncImage(url: URL(string: urlToImage)) { phase in
                if let image = phase.image {
                        // displays the loaded image
                    image
                        .resizable()
                        .scaledToFill()
                        .grayscale(1)
                } else if phase.error != nil {
                        // displays a subtitute image, if it's a bad url
                    Image("Logo_WhatIsTheNews-2")
                        .resizable()
                        .grayscale(1)
                } else {
                        // displays a wheel of progress while the image isn't loaded
                    ProgressView()
                        .background(Color.gray)
                }
            }
            .frame(width: width, height: height)
            .clipShape(Rectangle())
            .mask {
                LinearGradient(gradient: Gradient(colors: [.black, .black, .clear, .clear]),
                               startPoint: .top,
                               endPoint: .bottom)
            }
                // effect image
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
                // title of the news
            .overlay(alignment: .bottom) {
                Text(newsSelection[number].title)
                    .padding(.bottom, 17)
                    .padding([.trailing, .leading], 5)
                    .font(.system(size: 23))
                    .fontDesign(.serif)
                    .textCase(.uppercase)
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
        }
    }
}


    // MARK: - previews

struct SelectionCarouselOfTheNew_Previews: PreviewProvider {
    static var news = New.examples

    static var previews: some View {
        SelectionCarouselOfTheNew(newsSelection: news, number: 0, width: 350, height: 350)
    }
}
