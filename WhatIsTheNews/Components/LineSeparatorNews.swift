//
//  LineSeparatorNews.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 01/08/2023.
//

import SwiftUI

struct LineSeparatorNews: View {

        // MARK: - property wrappers

    @Environment (\.colorScheme) var colorScheme


        // MARK: - body

    var body: some View {
        VStack (alignment: .leading) {
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(colorScheme == .light ? .nightBlue : .paperJournal)

            Rectangle()
                .frame(width: 30, height: 5)
                .foregroundColor(.lightGreen)
                .offset(y: -8)
        }
    }
}


    // MARK: - previews

struct LineSeparatorNews_Previews: PreviewProvider {
    static var previews: some View {
        LineSeparatorNews()
    }
}
