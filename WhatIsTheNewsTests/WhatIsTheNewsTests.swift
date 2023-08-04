//
//  WhatIsTheNewsTests.swift
//  WhatIsTheNewsTests
//
//  Created by Greg Deveaux on 29/07/2023.
//

import XCTest
@testable import WhatIsTheNews

final class WhatIsTheNewsTests: XCTestCase {

    var viewModel: HomeViewModel!

    func test_ModelNew() throws {
            // with the first example
        let new = New.examples[0]

        XCTAssertNotNil(new)
        XCTAssertEqual(new.title, "Les joueuses jamaïcaines veulent faire pression sur la fédération")
        XCTAssertEqual(new.urlToImage, "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/07/28111756/6171886-hd-1400x933.jpg")
        XCTAssertEqual(new.description, "La qualif pour fermer les bouches. Lister les sélections qualifiées pour la Coupe du monde féminine qui ont subi de…")
        XCTAssertEqual(new.url, "https://www.sofoot.com/breves/les-joueuses-jamaicaines-veulent-faire-pression-sur-la-federation")
        XCTAssertEqual(new.author, "Arthur CHARLIER")
        XCTAssertEqual(new.source.name, "SO FOOT")
        XCTAssertEqual(new.publishedAt, "2023-07-28T09:18:16Z")
    }

    func testEqualBetweenNews() throws {
        let news = New.examples

        XCTAssertNotNil(news)
        XCTAssertEqual(news.count,4)
        XCTAssertNotEqual(news[0].url, news[1].url)
    }

    func testDelayPageLogo() async throws {
            // Given
        viewModel = HomeViewModel()
        XCTAssertEqual(viewModel?.indexOfThedisplayOfTheNewsSelection, 0)

        viewModel?.newsSelectionCarousel = New.examples
        XCTAssertEqual(viewModel?.newsSelectionCarousel.count, 4)

        var isMovingPageSelectionIsActivated: Bool = true

            // When
        await viewModel?.delayPageLogo(if: isMovingPageSelectionIsActivated, delay: 51_000_000)

            // Then
        XCTAssertEqual(viewModel?.indexOfThedisplayOfTheNewsSelection, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
