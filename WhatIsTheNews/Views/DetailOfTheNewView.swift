//
//  DetailOfTheNewView.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 31/07/2023.
//

import SwiftUI
import SafariServices

struct DetailOfTheNewView: View {

    @Environment (\.colorScheme) var colorScheme

    @State private var isPresentSafariView = false

    var new: New

    var body: some View {
        GeometryReader { screen in

            let widthScreen = screen.size.width
            let heightScreen = screen.size.height

            ZStack {
                Color.backgroundApp
                    .ignoresSafeArea()

                VStack {
                    AsyncImageDetailNew(new: new, width: widthScreen, height: heightScreen)
                        .overlay(alignment: .topTrailing) {
                            SourceName(sourceName: new.source.name)
                        }
                        .padding(.bottom, -165)

                    VStack {
                        VStack(alignment: .leading) {

                            Text(new.title)
                                .font(.system(size: 30))
                                .fontDesign(.serif)
                                .textCase(.uppercase)
                                .foregroundColor(colorScheme == .light ? .nightBlue : .lightGreen)
                                .padding(.trailing, 10)

                            Spacer()

                            Text(new.description ?? "")
                                .font(.callout)

                            HStack {
                                Spacer()

                                Text(new.author ?? "")
                                    .font(.caption2.italic())
                                    .fontWeight(.light)
                                    .padding(.trailing, 20)
                                    .padding(.top, 5)
                            }

                            Spacer()

                        }

                        Button {
                            isPresentSafariView = true
                        } label: {
                            HStack {
                                Image(systemName: "book")
                                Text("Voir l'article sur \(new.source.name)")
                            }
                            .foregroundColor(colorScheme == .light ? .lightGreen : .nightBlue)
                            .bold()
                            .padding(20)
                            .padding([.trailing, .leading], 20)
                            .background {
                                Capsule()
                                    .foregroundColor(colorScheme == .light ? .nightBlue : .lightGreen)
                            }
                        }
                        .fullScreenCover(isPresented: $isPresentSafariView) {
                            if let url = URL(string: new.url) {
                                SafariView(url: url)
                            }
                        }

                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 35)
                }
            }
        }
    }
}

struct DetailOfTheNewView_Previews: PreviewProvider {

    static var news = New.examples

    static var previews: some View {
        DetailOfTheNewView(new: news[0])
    }
}

struct AsyncImageDetailNew: View {

    @Environment (\.colorScheme) var colorScheme

    var new: New

    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                AsyncImageOfTheNew(new: new,
                                   width: width + 15,
                                   height: height / 1.5)
                .ignoresSafeArea()
                    // effect image

                Image("Dots-texture")
                    .resizable()
                    .scaledToFit()
                    .opacity(colorScheme == .light ? 0.3 : 0.2)
                    .mask {
                        LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .black, .clear, .clear]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
            }
            .mask {
                LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .black, .clear, .clear]),
                               startPoint: .top,
                               endPoint: .bottom)
            }
        }
        .blendMode(colorScheme == .light ? .normal : .exclusion)
        .ignoresSafeArea()
    }
}

struct SourceName: View {
    @Environment (\.dismiss) var dismiss

    var sourceName: String

    var body: some View {
        VStack {
            Text(sourceName)
                .bold()
                .foregroundColor(.nightBlue)
                .padding(.trailing, 30)
                .padding(10)
                .offset(x: 10)
                .background {
                    Capsule()
                        .foregroundColor(.lightGreen)
                }

            Image("Logo_WhatIsTheNews_Alpha")
                .resizable()
                .frame(width: 80, height: 80)
        }
        .offset(y: -20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.uturn.left.circle.fill")
                        Text("Retour")
                            .bold()
                    }
                    .foregroundColor(.lightGreen)
                }
            }
        }
    }
}
