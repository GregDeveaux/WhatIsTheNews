//
//  MockResponseData.swift
//  WhatIsTheNewsTests
//
//  Created by Greg Deveaux on 30/07/2023.
//

import XCTest

    // simulation of the different calls of currency API
final class MockResponseData {

        //MARK: - Mock responses
        // Create mock URL with statusCode Ok or failed
    static var apiURL = URL(string: "www.apple.fr")!

    static let responseOK = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseFailed = HTTPURLResponse(url: apiURL, statusCode: 500, httpVersion: nil, headerFields: nil)!
    static let badUrl = HTTPURLResponse(url: apiURL, statusCode: 404, httpVersion: nil, headerFields: nil)!


        //MARK: - Mock datas
        // recover bundle correct data for test
    static var newsApiCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let urlExample = bundle.url(forResource: "ExamplesNewsApi", withExtension: ".json")
        print("♻️: \(String(describing: urlExample))")
        let data = try! Data(contentsOf: urlExample!)
        return data
    }

        // create failed response of the simulation
    static let mockDataFailed = "notGood".data(using: .utf8)
}
