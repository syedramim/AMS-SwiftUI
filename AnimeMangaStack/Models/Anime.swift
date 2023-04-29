//
//  Anime.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/22/23.
//


import Foundation

struct Anime: Codable, Identifiable {
    let id =  UUID().uuidString
    var title: String?
    var episodes: Int?
    var status: String?
    var duration: String?
    var rating: String?
    var synopsis: String?
    var images: Images
    var trailer: Trailer
    var score: Double?
    var genres: [Names]
    var demographics: [Names]
    var producers: [Names]
    var licensors: [Names]
    var studios: [Names]
    
    
    enum CodingKeys: CodingKey {
        case title, episodes, status, duration, rating, synopsis, images, trailer, genres, demographics, score, producers, licensors, studios
    }
    
    var dictionary: [String: Any] {
        return [
            "title": title ?? "",
            "episodes": episodes ?? 0,
            "status": status ?? "",
            "duration": duration ?? "",
            "rating": rating ?? "",
            "synopsis": synopsis ?? "",
            "images": images.dictionary,
            "trailer": trailer.dictionary,
            "score": score ?? 0.0,
            "genres": genres.map { $0.dictionary },
            "demographics": demographics.map { $0.dictionary },
            "producers": producers.map { $0.dictionary },
            "licensors": licensors.map { $0.dictionary },
            "studios": studios.map { $0.dictionary }
        ]
    }
}


