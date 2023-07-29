//
//  CellOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import SwiftUI

struct CellOfTheNew: View {

    var new: New

    var body: some View {
        HStack (alignment: .top) {
            Text(new.title)

            AsyncImage(url: URL(string: new.urlToImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .grayscale(1)
            } placeholder: {
                ProgressView()
                    .background(Color.gray)
            }
            .frame(width: 100, height: 100)
            .clipShape(Rectangle())
        }
        .padding()
        .background(Color.red)
    }
}

struct CellOfTheNew_Previews: PreviewProvider {
    static let new = New.examples[3]

    static var previews: some View {
        CellOfTheNew(new: new)
    }
}
