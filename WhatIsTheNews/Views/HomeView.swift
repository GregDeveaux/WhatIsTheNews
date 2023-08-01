//
//  HomeView.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import SwiftUI

struct HomeView: View {

        // MARK: - Property wrappers

    @Environment (\.colorScheme) var colorScheme
    @StateObject var viewModel = HomeViewModel()

    @State private var isMovingPageIsActivated = false


        // MARK: - Body

    var body: some View {
        GeometryReader { screen in

            let screenWidth = screen.size.width

            NavigationStack {
                ZStack {
                    Color.backgroundApp
                        .ignoresSafeArea()

                    ScrollView {
                        VStack {
                            CarouselOfNews(width: screenWidth - 50, height: screenWidth - 50)
                                .environmentObject(viewModel)
                                .offset(y: -10)

                            LineSeparatorNews()
                                .padding(.bottom, 2)
                                .padding([.leading, .trailing])
                        }
                        .onAppear {
                            isMovingPageIsActivated = true
                            Task {
                                await viewModel.delayPageLogo(if: !isMovingPageIsActivated,
                                                              delay: 5_000_000_000)
                            }
                        }

                        ForEach($viewModel.news, id: \.id) { $new in
                            NavigationLink {
                                DetailOfTheNewView(new: new)
                            } label: {
                                CellOfTheNew(new: new)
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            try await viewModel.getNews(with: "cinema")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CarouselOfNews: View {
    @EnvironmentObject var viewModel: HomeViewModel

    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        TabView(selection: $viewModel.pageIndex) {
            Image("Logo_WhatIsTheNews_Alpha")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .tag(0)
            PageOfTheNew(number: 0, width: width, height: height)
                .environmentObject(viewModel)
                .tag(1)
            PageOfTheNew(number: 1, width: width, height: height)
                .environmentObject(viewModel)
                .tag(2)
            PageOfTheNew(number: 3, width: width, height: height)
                .environmentObject(viewModel)
                .tag(3)
        }
        .tabViewStyle(.page)
        .frame(height: 450)
        .onAppear {
            colorDotTabView()
        }
    }

        /// Description: allows to change a color of dot index of TabView
    func colorDotTabView() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .green
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.green.withAlphaComponent(0.2)
    }
}
