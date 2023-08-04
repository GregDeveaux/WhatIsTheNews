//
//  AsyncImageOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 01/08/2023.
//

import SwiftUI

struct AsyncImageOfTheNew: View {

        // MARK: - properties

    var new: New
    var width: CGFloat
    var height: CGFloat


        // MARK: - body

    var body: some View {
        if let urlToImage = new.urlToImage {
            AsyncImage(url: URL(string: urlToImage)) { phase in
                if let image = phase.image {
                        // displays the loaded image
                    image
                        .resizable()
                        .scaledToFill()
                        .grayscale(1)
                        .onAppear {

                        }
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
        } else {
                // displays a subtitute image, if there isn't image
            Image("Logo_WhatIsTheNews-2")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}


    // MARK: - previews

struct AsyncImageOfTheNew_Previews: PreviewProvider {
    static var new = New.examples[0]

    static var previews: some View {
        AsyncImageOfTheNew(new: new,
                           width: 100,
                           height: 100)
    }
}
