//
//  Genre.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable {
    
    var id: Int { rawValue }
    
    case action = 1
    case adventure
    case animation
    case comedy
    case drama
    case fantasy
    case horror
    case romance
    case scienceFiction
    case thriller
    case western
    case indian
    case crime
}

extension Genre {
    var name: String {
        switch self {
        case .action:
            return "Action"
            
        case .adventure:
            return "Adventure"
            
        case .animation:
            return "Animation"
            
        case .comedy:
            return "Comedy"
            
        case .drama:
            return "Drama"
            
        case .fantasy:
            return "Fantasy"
            
        case .horror:
            return "Horror"
            
        case .romance:
            return "Romance"
            
        case .scienceFiction:
            return "Science Fiction"
            
        case .thriller:
            return "Thriller"
            
        case .western:
            return "Western"
            
        case .indian:
            return "Indian"
            
        case .crime:
            return "Crime"
        }
    }
}
