//
//  NewsApiTests.swift
//  WhatIsTheNewsTests
//
//  Created by Greg Deveaux on 30/07/2023.
//

import XCTest
@testable import WhatIsTheNews

final class NewsApiTests: XCTestCase {

    var urlSession: URLSession!
    var expectation: XCTestExpectation!
    var statusCode: Int!

    var viewModel: HomeViewModel?
    let keyword = "coupe du monde féminine"

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
            // Transform URLProtocol from MockURLProtocol
        URLProtocol.registerClass(MockURLProtocol.self)

            // Setup a configuration to use our mock
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

            // Create the URLSession configurated
        urlSession = URLSession(configuration: configuration)
        statusCode = 200
    }

    override func tearDownWithError() throws {
            // Stop the modification of class URLProtocol
        URLProtocol.unregisterClass(MockURLProtocol.self)
        viewModel = nil
    }

        //MARK: - test endPoint

    func test_UrlIsOk() throws {
            // Given
        let urlOFnewsApi: String = "https://newsapi.org/v2/everything?q=coupe%20du%20monde%20f%C3%A9minine&language=fr&sortBy=publishedAt"

            // When
        let urlWished = URL(string: urlOFnewsApi)
        let urlCreated = viewModel?.createUrl(to: keyword)

            // Then
        XCTAssertEqual(urlCreated, urlWished)
    }

        //MARK: - asyncTest for newsApi with mock

    func test_NewsResearchWithGoodDataAndResponseOK() async throws {
            // Given
        baseQuery(data: MockResponseData.newsApiCorrectData, response: MockResponseData.responseOK)

            // When
        do {
            try await viewModel?.getNews(with: keyword)

            let new = viewModel?.news[0]

            // Then
            XCTAssertNotNil(viewModel?.news)
            XCTAssertEqual(new?.title, "Les joueuses jamaïcaines veulent faire pression sur la fédération")
            XCTAssertEqual(new?.urlToImage, "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/07/28111756/6171886-hd-1400x933.jpg")
            XCTAssertEqual(new?.author, "Arthur CHARLIER")
            XCTAssertEqual(new?.description, "La qualif pour fermer les bouches. Lister les sélections qualifiées pour la Coupe du monde féminine qui ont subi de…")
            XCTAssertEqual(new?.url, "https://www.sofoot.com/breves/les-joueuses-jamaicaines-veulent-faire-pression-sur-la-federation")
            XCTAssertEqual(new?.publishedAt, "2023-07-28T09:18:16Z")
            XCTAssertEqual(new?.source.name, "SO FOOT")

        } catch {
            XCTFail("🛑 There is an error in the test_NewsResearchWithGoodDataAndResponseOK: \(error)")
        }
    }

    func test_NewsResearchWithGoodDataAndResponseFailedCode500() async throws {
            // Given
        baseQuery(data: MockResponseData.newsApiCorrectData, response: MockResponseData.responseFailed)

            // When
        do {
            try await viewModel?.getNews(with: keyword)

                // Then
            XCTFail("🛑 There is an error in the test_NewsResearchWithGoodDataAndResponseFailedCode500")
        } catch {
            XCTAssertEqual(error as? ApiError, .invalidResponse)
            XCTAssertEqual(statusCode, 500, "Expected a 500 response failed.")
        }
    }

    func test_NewsResearchWithBadDataAndResponseOk() async throws {
            // Given
        baseQuery(data: MockResponseData.mockDataFailed, response: MockResponseData.responseOK)

            // When
        do {
            try await viewModel?.getNews(with: keyword)

                // Then
            XCTFail("🛑 There is an error in the test_NewsResearchWithBadDataAndResponseOk")
        } catch {
            XCTAssertEqual(error as? ApiError, .invalidData)
            XCTAssertEqual(statusCode, 200, "Expected a 200 response OK.")
        }
    }

    func test_NewsResearchButTheUrlIsPhony() async throws {
            // Given
        baseQuery(data: MockResponseData.newsApiCorrectData, response: MockResponseData.badUrl)

            // When
        do {
            try await viewModel?.getNews(with: keyword)

                // Then
            XCTFail("🛑 There is an error in the test_NewsResearchButTheUrlIsPhony")
        } catch {
            XCTAssertEqual(error as? ApiError, .invalidUrl)
            XCTAssertEqual(statusCode, 404, "Expected a 404, the requested resource doesn’t exist.")
        }
    }

        //MARK: - baseQuery for the mock

    private func baseQuery(data: Data?, response: HTTPURLResponse) {

        let data = data

        MockURLProtocol.requestHandler = { request in
            let response = response
            self.statusCode = response.statusCode
            return (response, data)
        }
    }

}
