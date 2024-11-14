//
//  MovieDetail.swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import Foundation

struct MovieDetail: Codable{
    let title: String
    let description: String
    let year: String
    let youtubeTrailerKey: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case description
        case youtubeTrailerKey = "youtube_trailer_key"
    }
}
