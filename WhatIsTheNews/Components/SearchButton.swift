//
//  SearchButton.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 03/08/2023.
//

import SwiftUI

struct SearchButton: View {

    @Binding var isOpenedSheetToSearchKeyword: Bool

    var body: some View {

        HStack {
            Spacer()

            VStack {
                Spacer()

                Button {
                    isOpenedSheetToSearchKeyword = true
                } label: {
                    Circle()
                        .foregroundColor(.lightGreen)
                        .opacity(0.7)
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "sparkle.magnifyingglass")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(.white)
                                .offset(x: -23, y: -23)
                        }
                        .background(.ultraThinMaterial.opacity(0.9))
                        .clipShape(Circle())
                }
                .frame(width: 90)
            }
        }
        .padding([.trailing, .bottom], 20)
        .ignoresSafeArea()
    }
}

struct SearchButton_Previews: PreviewProvider {

    static var previews: some View {
            SearchButton(isOpenedSheetToSearchKeyword: .constant(true))
    }
}
