//
//  CarouselOfNews.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 02/10/2023.
//

import SwiftUI

    //MARK: - Views

struct CarouselOfNews: View {

    @Binding var newsSelectionCarousel: [New]
    @State var indexOfThedisplayOfTheNewsSelection: Int = 0

    @Binding var isMovingPageSelectionIsActivated: Bool

    var width: CGFloat
    var height: CGFloat

    var body: some View {
        TabView(selection: $indexOfThedisplayOfTheNewsSelection) {
            Image("Logo_WhatIsTheNews_Alpha")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .tag(0)

            if newsSelectionCarousel.count > 3 {
                SelectionCarouselOfTheNew(newsSelection: newsSelectionCarousel,
                             index: 0,
                             width: width,
                             height: height)
                    .tag(1)
                SelectionCarouselOfTheNew(newsSelection: newsSelectionCarousel,
                             index: 1,
                             width: width,
                             height: height)
                    .tag(2)
                SelectionCarouselOfTheNew(newsSelection: newsSelectionCarousel,
                             index: 2,
                             width: width,
                             height: height)
                    .tag(3)
            }
        }
        .tabViewStyle(.page)
        .frame(height: 450)
        .offset(y: -10)
        .onAppear {
                // Active the dots of tab with a green color
            colorDotTabView(color: .green)
                // Active page switching
            isMovingPageSelectionIsActivated = true
                // each 5 secondes, the page changes
            Task {
                await delayPageLogo(if: isMovingPageSelectionIsActivated,
                                    delay: 5_000_000_000)
            }
        }
    }

}


    // MARK: - previews

struct CarouselOfNews_Previews: PreviewProvider {
    static var news = New.examples

    static var previews: some View {
        CarouselOfNews(
            newsSelectionCarousel: .constant(news),
            isMovingPageSelectionIsActivated: .constant(true),
            width: 350,
            height: 350
        )
    }
}


extension CarouselOfNews {


        //MARK: - display the green dots under the frame

        /// Description: allows to change a color of dot index of TabView
        /// - Parameter color: choose the color of the dots
    func colorDotTabView(color: UIColor) {
        UIPageControl.appearance().currentPageIndicatorTintColor = color
        UIPageControl.appearance().pageIndicatorTintColor = color.withAlphaComponent(0.2)
    }


        //MARK: - display carousel logo/news animated

        /// Description: Allows to animate the carousel of the news
        /// - Parameter activated: indicate if the moving page is activate
        /// - Parameter delay: between the display screen
    func delayPageLogo(if activated: Bool, delay: UInt64) async {
        var round = 0
        while activated && round <= 32 {
            if indexOfThedisplayOfTheNewsSelection <= newsSelectionCarousel.count - 1 {
                try? await Task.sleep(nanoseconds: delay)
                indexOfThedisplayOfTheNewsSelection += 1
                print("new pageIndex: \(indexOfThedisplayOfTheNewsSelection)")

            } else {
                indexOfThedisplayOfTheNewsSelection = 0
                print("new pageIndex: \(indexOfThedisplayOfTheNewsSelection)")
            }
            round += 1
        }
    }
}
