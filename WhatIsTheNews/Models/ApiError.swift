//
//  ApiError.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

enum ApiError: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData

    var errorDescription: String? {
        switch self {
            case .invalidUrl:
                return "⚠️ 📤 invalid URL ⚠️"
            case .invalidResponse:
                return "⚠️ 📭 invalid Response ⚠️"
            case .invalidData:
                return "⚠️ 📩 invalid Data ⚠️"
        }
    }
}
