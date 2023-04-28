//
//  RateOptions.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/28/23.
//

import Foundation

enum RateOptions: CaseIterable {
  case finished
  case dropped
  case InProgress
  case OnHold
    
    var contentStatus: String {
        switch self {
        case .finished:
            return "Finished"
        case .dropped:
            return "Dropped"
        case .InProgress:
            return "In Progress"
        case .OnHold:
            return "On Hold"
        }
        
    }
}


