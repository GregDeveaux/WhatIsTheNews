//
//  SearchView.swift
//  WhatIsTheNews
//
//  Created by Greg-Mini on 02/08/2023.
//

import SwiftUI

struct SearchView: View {

//    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color.lightGreen
                .ignoresSafeArea()

            VStack {
                Image("Logo_WhatIsTheNews_Alpha")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .blendMode(.difference)

                LineSeparatorNews()

                SearchBar()
                    .environmentObject(viewModel)

                LineSeparatorNews()

                SearchCategories()
                    .environmentObject(viewModel)

                Spacer()
            }
            .padding(20)
            .onAppear {
                viewModel.keyword = ""
                print("✅ SEARCH_VIEW/ON_APPEAR: keyword is \"\(viewModel.keyword)\"")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static let viewModel = HomeViewModel()

    static var previews: some View {
        SearchView()
            .environmentObject(viewModel)
    }
}

struct SearchBar: View {
    @Environment (\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "sparkle.magnifyingglass")
                .font(.system(size: 25))
                .bold()
            TextField("Indique un mot clé", text: $viewModel.keyword)
                .font(.system(size: 16).monospaced())
                .foregroundColor(.nightBlue)
                .frame(height: 50)
                /// allows to create a keyboard button search
                .submitLabel(.search)
                /// allows to block the submit if there isn't a keyboard
                .submitScope(viewModel.keyword == "")
                /// allows to send action after press search button
                .onSubmit {
                    Task {
                        try await viewModel.getNews(with: viewModel.keyword)
                        print("✅ SEARCH_VIEW/ON_SUBMIT: search is activated")
                    }
                    dismiss()
                }
        }
        .padding(.top, -16)
    }
}

struct SearchCategories: View {

    @Environment (\.dismiss) var dismiss

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        GeometryReader { screen in
            let widthScreen = screen.size.width

            let gridItem = GridItem(.flexible(), spacing: 40)

            let columns: [GridItem] = [gridItem, gridItem, gridItem]

            VStack {
                Text("–– ou choisi une catégorie ––")
                    .font(.system(size: 16).monospaced())
                    .offset(y: 12)

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach($viewModel.categories, id: \.self) { $category in
                        Button {
                            viewModel.keyword = category
                            Task {
                                try await viewModel.getNews(with: viewModel.keyword)
                            }
                            dismiss()
                        } label: {
                            Text(category.uppercased())
                                .font(.system(size: 15))
                                .tracking(1.5)
                                .fontWidth(.compressed)
                                .foregroundColor(.lightGreen)
                                .padding([.top, .bottom], 10)
                                .background {
                                    Capsule()
                                        .foregroundColor(.nightBlue)
                                        .frame(width: widthScreen / 3)
                                }
                        }
                    }
                }
                .padding(10)
            }
        }
    }
}
