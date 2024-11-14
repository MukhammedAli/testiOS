//
//  MovieResponse.swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import Foundation

struct MovieResponse: Codable{
    let movieResults: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID = "imdb_id"
    }
}

struct MovieImageResponse: Codable {
    let poster: String
}
