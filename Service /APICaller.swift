//
//  APICaller.swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import Foundation
import Alamofire

class APICaller {
    enum RequestType: String {
        case trendingMovies = "get-trending-movies"
        case detail = "get-movie-details"
        case image = "get-movies-images-by-imdb"
    }
    private let baseURL = "https://movies-tv-shows-database.p.rapidapi.com"
    private let apiKey = "a57219f6bemshfc6a90de39c6b3ap1cb460jsn7114a3c01df0"
    private let apiHost = "movies-tv-shows-database.p.rapidapi.com"

    static let shared = APICaller()
    
    func get<T: Codable>(with url: String, and type: RequestType) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(url)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.setValue(type.rawValue, forHTTPHeaderField: "Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 10

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }
}
