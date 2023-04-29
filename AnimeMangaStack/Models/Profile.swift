//
//  Profile.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Profile: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String?
    var animesWatched: [userAnime]?
    var mangasRead: [userManga]?
    
    var dictionary: [String: Any] {
        return [
            "email": email ?? "",
            "animesWatched": animesWatched?.map { $0.dictionary } ?? [],
            "mangasRead": mangasRead?.map { $0.dictionary } ?? []
        ]
    }
}


struct userAnime: Codable {
    var anime: Anime
    var status: RateOptions
    var score: Int
    var watchedEpisodes: Int
    
    var dictionary: [String: Any] {
        return [
            "anime": anime.dictionary,
            "status": status.rawValue,
            "score": score,
            "watchedEpisodes": watchedEpisodes
        ]
    }
}

struct userManga: Codable {
    var manga: Manga
    var status: RateOptions
    var score: Int
    var readChapters: Int
    var readVolumes: Int
    
    var dictionary: [String: Any] {
        return [
            "manga": manga.dictionary,
            "status": status.rawValue,
            "score": score,
            "readChapters": readChapters,
            "readVolumes": readVolumes
        ]
    }
}

