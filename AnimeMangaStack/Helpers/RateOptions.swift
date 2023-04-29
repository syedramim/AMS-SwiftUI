//
//  RateOptions.swift
//  AnimeMangaStack
//  Created by Kaneis Zontanos on 4/28/23.
//

import Foundation

enum RateOptions: String, CaseIterable, Codable {
    case finished = "Finished"
    case dropped = "Dropped"
    case inProgress = "In Progress"
    case onHold = "On Hold"
    
    var contentStatus: String {
        return self.rawValue
    }
}



