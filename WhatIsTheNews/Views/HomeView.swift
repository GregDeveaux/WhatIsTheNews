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

    @State private var pageMovingIsActivated = false
    @State private var isOpenedSheetToSearchKeyword = false
    @State private var isFirstActivation: Bool = false


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
                            CarouselOfNews(
                                selectionOfTheNewsOfCarousel: $viewModel.newsSelectionOfCarousel,
                                PageMovingIsActivated: $pageMovingIsActivated,
                                width: screenWidth - 50,
                                height: screenWidth - 50
                            )
                            .environmentObject(viewModel)

                            LineSeparatorNews()
                                .padding(.bottom, 2)
                                .padding([.leading, .trailing])
                        }

                        ListOfTheNews()
                            .environmentObject(viewModel)
                    }

                    SearchButton(isOpenedSheetToSearchKeyword: $isOpenedSheetToSearchKeyword)
                }
            }
            .onAppear {
                isFirstActivation = true
                print("✅1️⃣ HOME_VIEW/ON_APPEAR: first activation of the app, run carousel")

                if isFirstActivation {
                    print("✅2️⃣ HOME_VIEW/ON_APPEAR: carousel selection is activated")
                    Task(priority: .high) {
                        print("✅3️⃣ HOME_VIEW/ON_APPEAR: call api for the carousel")
                        try await viewModel.getNews(with: "chanson")
                    }
                }

                if viewModel.keyword.isEmpty {
                    viewModel.keyword = "iPhone"
                    Task(priority: .low) {
                        try await viewModel.getNews(with: viewModel.keyword)
                        print("✅5️⃣ HOME_VIEW/ON_APPEAR: initial search is activated")
                    }
                }
            }
            .sheet(isPresented: $isOpenedSheetToSearchKeyword) {
                SearchView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ListOfTheNews: View {

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            ForEach($viewModel.news, id: \.id) { $new in
                NavigationLink {
                    DetailOfTheNewView(new: new)
                } label: {
                    CellOfTheNew(new: new)
                }
            }
        }
    }
}
