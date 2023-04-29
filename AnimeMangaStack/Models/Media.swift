//
//  Media.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/26/23.
//

import Foundation

struct Images: Codable {
    var jpg: ImageLink
    var webp: ImageLink
    
    var dictionary: [String: Any] {
        return [
            "jpg": jpg.dictionary,
            "webp": webp.dictionary
        ]
    }
}

struct ImageLink: Codable {
    var image_url: String?
    var small_image_url: String?
    var large_image_url: String?
    
    var dictionary: [String: Any] {
        return [
            "image_url": image_url ?? "",
            "small_image_url": small_image_url ?? "",
            "large_image_url": large_image_url ?? ""
        ]
    }
}

struct Trailer: Codable {
    var youtube_id: String?
    
    var dictionary: [String: Any] {
        return [
            "youtube_id": youtube_id ?? ""
        ]
    }
}

struct Names: Codable {
    var name: String?
    
    var dictionary: [String: Any] {
        return [
            "name": name ?? ""
        ]
        
    }
}
