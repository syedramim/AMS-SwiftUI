//
//  Anime.swift
//  AnimeMangaStack
//
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
}


