//
//  HomeViewModel.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

class HomeViewModel: ObservableObject {

        // MARK: - Property wrappers

    @Published var news: [New] = New.examples


        // MARK: - Header Endpoint

    var header: [String: String] {
        let key = APIKeys.NewsApi.key.rawValue
        let value = APIKeys.NewsApi.value.rawValue
        return [key: value]
    }


        // MARK: - get the different News from NewsApi

    func getNews(with keyWord: String) async throws {

        let url = createUrl(to: keyWord)

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
                case 200:
                    do {
                        print("✅ HOME_VIEW_MODELS/GET_NEWS: the task received \(String(data: data, encoding: .utf8)!)")

                        let decoder = JSONDecoder()
                        let newsData = try decoder.decode(NewsApiResult.self, from: data)

                        await saveTheNews(newsData)
                    }
                    catch {
                        print("🛑 HOME_VIEW_MODELS/GET_NEWS: Decoding error: \(String(describing: ApiError.invalidData.errorDescription))")
                        throw ApiError.invalidData
                    }
                case 400...451:
                    print("🛑 HOME_VIEW_MODELS/GET_NEWS: Decoding error: \(String(describing: ApiError.invalidUrl.errorDescription))")
                    throw ApiError.invalidUrl

                case 500...511:
                    print("🛑 HOME_VIEW_MODELS/GET_NEWS: Decoding error: \(String(describing: ApiError.invalidResponse.errorDescription))")
                    throw ApiError.invalidResponse

                default:
                    return
            }
        }
    }


        // MARK: - create the url

    func createUrl(to search: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "q", value: search),
            URLQueryItem(name: "language", value: "fr"),
            URLQueryItem(name: "sortBy", value: "publishedAt")
        ]

        guard let url = components.url else {
            preconditionFailure("🛑 HOME_VIEW_MODEL/CREATE_URL: \(ApiError.invalidUrl)")
        }

        print("✅ HOME_VIEW_MODEL/CREATE_URL: the url used to search \(search) is: \(url)")

        return url
    }


        // MARK: - save the result (thread main)

    @MainActor
    func saveTheNews(_ results: NewsApiResult) {
        for result in results.news {
            let new = New(title: result.title,
                          urlToImage: result.urlToImage,
                          description: result.description,
                          url: result.url,
                          author: result.author,
                          source: result.source,
                          publishedAt: result.publishedAt)
            news.append(new)
        }
    }
}
