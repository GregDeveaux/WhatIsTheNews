//
//  NewsApiResult.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

struct NewsApiResult: Codable {
    let totalResults: Int
    let news: [New]

    enum CodingKeys: String, CodingKey {
        case totalResults
        case news = "articles"
    }
}

struct Source: Codable {
    let name: String
}
