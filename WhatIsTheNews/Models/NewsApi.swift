//
//  NewsApi.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

struct NewsApi {
    let totalResults: Int
    let news: [New]

    enum codingkeys: String, CodingKey {
        case totatResults
        case news = "articles"
    }
}
