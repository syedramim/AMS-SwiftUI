//
//  Manga.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/26/23.
//

import Foundation

struct Manga: Codable, Identifiable {
    let id =  UUID().uuidString
    var title: String?
    var chapters: Int?
    var volumes: Int?
    var status: String?
    var rating: String?
    var synopsis: String?
    var images: Images
    var score: Double?
    var genres: [Names]
    var demographics: [Names]
    var serializations: [Names]
    
    
    
    enum CodingKeys: CodingKey {
        case title, chapters, status, rating, synopsis, images, genres, demographics, score, volumes, serializations
    }
    
    var dictionary: [String: Any] {
        return [
            "title": title ?? "",
            "chapters": chapters ?? 0,
            "volumes": volumes ?? 0,
            "status": status ?? "",
            "rating": rating ?? "",
            "synopsis": synopsis ?? "",
            "images": images.dictionary,
            "score": score ?? 0.0,
            "genres": genres.map { $0.dictionary },
            "demographics": demographics.map { $0.dictionary },
            "serializations": serializations.map { $0.dictionary }
        ]
    }
}


