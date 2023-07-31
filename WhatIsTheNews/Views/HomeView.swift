//
//  HomeView.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    @State private var isMovingPageIsActivated = false

    var body: some View {
        ZStack {
            Color.backgroundApp
                .ignoresSafeArea()

            VStack {
                CarouselOfNews()
                    .environmentObject(viewModel)

                Rectangle()
                    .frame(width: 350, height: 1, alignment: .center)

                Spacer()
            }
            .onAppear {
                isMovingPageIsActivated = true
                Task {
                    await delayPageLogo()
                }
            }


//            NavigationStack {
//                VStack {
//
//                    List($viewModel.news, id: \.id) { $new in
//                        NavigationLink {
//                            DetailOfTheNewView()
//                        } label: {
//                            CellOfTheNew(new: new)
//                        }
//                    }
//                }
//
//
//            }
//            .onAppear {
//                Task {
//                    try await viewModel.getNews(with: "roi")
//                }
//        }
        }
    }



    func delayPageLogo() async {
        while isMovingPageIsActivated {
            if viewModel.pageIndex <= viewModel.newsSelection.count - 1 {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                viewModel.pageIndex += 1
            } else {
                viewModel.pageIndex = 0
                print("new pageIndex")
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
    var body: some View {
        TabView(selection: $viewModel.pageIndex) {
            Image("Logo_WhatIsTheNews_Alpha")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .tag(0)
            PageOfTheNew(number: 0)
                .environmentObject(viewModel)
                .tag(1)
            PageOfTheNew(number: 2)
                .environmentObject(viewModel)
                .tag(2)
            PageOfTheNew(number: 3)
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
