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
                            CarouselOfNews(isMovingPageSelectionIsActivated: $isMovingPageIsActivated,
                                           width: screenWidth - 50,
                                           height: screenWidth - 50)
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
                    viewModel.thisIsForSelectionCarousel = true
                    print("✅2️⃣ HOME_VIEW/ON_APPEAR: carousel selection is activated")
                    Task(priority: .high) {
                        print("✅3️⃣ HOME_VIEW/ON_APPEAR: call api for the carousel")
                        try await viewModel.getNews(with: "climat")
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


    //MARK: - Views

struct CarouselOfNews: View {

    @EnvironmentObject var viewModel: HomeViewModel

    @Binding var isMovingPageSelectionIsActivated: Bool

    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        TabView(selection: $viewModel.indexOfThedisplayOfTheNewsSelection) {
            Image("Logo_WhatIsTheNews_Alpha")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .tag(0)

            if viewModel.newsSelectionCarousel.count > 3 {
                SelectionCarouselOfTheNew(newsSelection: viewModel.newsSelectionCarousel,
                             number: 0,
                             width: width,
                             height: height)
                    .environmentObject(viewModel)
                    .tag(1)
                SelectionCarouselOfTheNew(newsSelection: viewModel.newsSelectionCarousel,
                             number: 1,
                             width: width,
                             height: height)
                    .environmentObject(viewModel)
                    .tag(2)
                SelectionCarouselOfTheNew(newsSelection: viewModel.newsSelectionCarousel,
                             number: 2,
                             width: width,
                             height: height)
                    .environmentObject(viewModel)
                    .tag(3)
            }
        }
        .tabViewStyle(.page)
        .frame(height: 450)
        .offset(y: -10)
        .onAppear {
            colorDotTabView()

            isMovingPageSelectionIsActivated = true
            Task {
                await viewModel.delayPageLogo(if: !isMovingPageSelectionIsActivated,
                                              delay: 5_000_000_000)
            }
        }
    }

        /// Description: allows to change a color of dot index of TabView
    func colorDotTabView() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .green
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.green.withAlphaComponent(0.2)
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
