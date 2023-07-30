//
//  HomeView.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            List($viewModel.news, id: \.id) { $new in
                CellOfTheNew(new: new)
            }
        }
        .onAppear {
            Task {
                try await viewModel.getNews(with: "france")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
