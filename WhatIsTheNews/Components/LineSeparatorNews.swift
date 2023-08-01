//
//  LineSeparatorNews.swift
//  WhatIsTheNews
//
//  Created by Greg-Mini on 01/08/2023.
//

import SwiftUI

struct LineSeparatorNews: View {

    @Environment (\.colorScheme) var colorScheme

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

struct LineSeparatorNews_Previews: PreviewProvider {
    static var previews: some View {
        LineSeparatorNews()
    }
}
