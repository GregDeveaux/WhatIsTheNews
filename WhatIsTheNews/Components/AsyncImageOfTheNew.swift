//
//  AsyncImageOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg-Mini on 01/08/2023.
//

import SwiftUI

struct AsyncImageOfTheNew: View {

    var stringUrl: String
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: stringUrl)) { phase in
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
            } else {
                    // displays a wheel of progress while the image isn't loaded
                ProgressView()
                    .background(Color.gray)
            }
        }
        .frame(width: width, height: height)
        .clipShape(Rectangle())
    }
}


struct AsyncImageOfTheNew_Previews: PreviewProvider {
    static var viewModel = HomeViewModel()

    static var previews: some View {
        AsyncImageOfTheNew(stringUrl: viewModel.news[0].urlToImage ?? "",
                           width: 100,
                           height: 100)
    }
}
