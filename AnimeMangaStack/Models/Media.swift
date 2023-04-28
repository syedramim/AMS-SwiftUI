//
//  Media.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/26/23.
//

import Foundation

struct Images: Codable {
    var jpg: ImageLink
    var webp: ImageLink
}

struct ImageLink: Codable {
    var image_url: String?
    var small_image_url: String?
    var large_image_url: String?
}

struct Trailer: Codable {
    var youtube_id: String?
}

struct Names: Codable {
    var name: String?
}
