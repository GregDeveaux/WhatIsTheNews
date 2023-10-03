//
//  CellOfTheNew.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import SwiftUI

struct CellOfTheNew: View {

        // MARK: - property wrapper

    @Environment (\.colorScheme) var colorScheme


        // MARK: - property

    var new: New


        // MARK: - body

    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                Text(new.title)
                    .font(.system(size: 16).monospaced())
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .foregroundColor(colorScheme == .light ? .nightBlue : .paperJournal)
                    .frame(height: 100)

                Spacer()

                AsyncImageOfTheNew(
                    new: new,
                    width: 100,
                    height: 100
                )
            }

            LineSeparatorNews()
        }
        .padding([.leading, .trailing])
        .padding(.top, -14)
    }
}


    // MARK: - previews

struct CellOfTheNew_Previews: PreviewProvider {
    static let new = New.examples[2]

    static var previews: some View {
        CellOfTheNew(new: new)
    }
}
