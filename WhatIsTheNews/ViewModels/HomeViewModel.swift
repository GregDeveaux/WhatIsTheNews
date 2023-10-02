//
//  HomeViewModel.swift
//  WhatIsTheNews
//
//  Created by Greg Deveaux on 29/07/2023.
//

import Foundation

class HomeViewModel: ObservableObject {

        // MARK: - Property wrappers

    @Published var news: [New] = []

    @Published var newsSelectionCarousel: [New] = []
    @Published var thisIsForSelectionCarousel: Bool = false
    @Published var carouselIsCompleted: Bool = false

    @Published var indexOfThedisplayOfTheNewsSelection: Int = 0

    @Published var keyword: String = ""

        // limited to 9
    @Published var categories: [String] = ["Sport", "Cinéma", "Apple", "Gastronomie", "Science", "Histoire", "Spectacle", "Nature", "Cosplay"]


        // MARK: - Header Endpoint

    var header: [String: String] {
        let key = APIKeys.NewsApi.key.rawValue
        let value = APIKeys.NewsApi.value.rawValue
        return [key: value]
    }


        // MARK: - Get the different News from NewsApi

    func getNews(with keyWord: String) async throws {

        let url = createUrl(to: keyWord)

        var request = URLRequest(url: url)
            // allows to include the apiKeys in the header
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

                        thisIsForSelectionCarousel = false
                        print("✅4️⃣ HOME_VIEW/GET_NEWS: carousel selection is desactivated")
                    }
                    catch let error as DecodingError {
                        print("🛑 HOME_VIEW_MODELS/GET_NEWS: Decoding error: \(String(describing: ApiError.invalidData.errorDescription))")
                        describesInTheConsoleTheDecodingError(error)
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


        // MARK: - Create the url

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

            // delete the old values
        news.removeAll()

                    // then save each decoding result
        for result in results.news {
            let new = New(title: result.title,
                          urlToImage: result.urlToImage,
                          description: result.description,
                          url: result.url,
                          author: result.author,
                          source: result.source,
                          publishedAt: result.publishedAt)

            if thisIsForSelectionCarousel {
                newsSelectionCarousel.append(new)

                carouselIsCompleted = true
                print("✅ HOME_VIEW_MODELS/SAVE_THE_NEWS: the Carousel is completed : \(newsSelectionCarousel.count)")

            } else {
                news.append(new)
                print("✅ HOME_VIEW_MODELS/SAVE_THE_NEWS: the news is completed : \(news.count)")
            }
        }
    }

    
        //MARK: - DecodingError

        /// Description: Describes in the console debug the decoding error
        /// - Parameter error: error found when the problem with decode the json
    func describesInTheConsoleTheDecodingError(_ error: DecodingError) {
        switch error {
            case .typeMismatch(let key, let value):
                print("💢TYPE_MISMATCH: error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .valueNotFound(let key, let value):
                print("❓VALUE_NOT_FOUND: error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .keyNotFound(let key, let value):
                print("❓KEY_NOT_FOUND: error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .dataCorrupted(let key):
                print("♨️ DATA_CORRUPTED: error \(key), and ERROR: \(error.localizedDescription)")
            default:
                print("ERROR: \(error.localizedDescription)")
        }
    }
}
