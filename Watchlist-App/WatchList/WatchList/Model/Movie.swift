//
//  Movie.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import Foundation
import SwiftData

@Model
class Movie {
    var id = UUID()
    var createdAt: Date = Date()
    var title: String
    var genre: Genre
    
    init(title: String, genre: Genre) {
        self.title = title
        self.genre = genre
    }
}

extension Movie {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Movie.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Movie(title: "Inception", genre: Genre(rawValue: 1)!))
        container.mainContext.insert(Movie(title: "Interstellar", genre: Genre(rawValue: 2)!))
        container.mainContext.insert(Movie(title: "The Dark Knight", genre: Genre(rawValue: 3)!))
        container.mainContext.insert(Movie(title: "Mad Max: Fury Road", genre: Genre(rawValue: 4)!))
        container.mainContext.insert(Movie(title: "The Godfather", genre: Genre(rawValue: 5)!))
        container.mainContext.insert(Movie(title: "John Wick", genre: Genre(rawValue: 1)!))
        container.mainContext.insert(Movie(title: "The Shawshank Redemption", genre: Genre(rawValue: 2)!))
        container.mainContext.insert(Movie(title: "The Godfather: Part II", genre: Genre(rawValue: 3)!))
        container.mainContext.insert(Movie(title: "The Dark Knight Rises", genre: Genre(rawValue: 4)!))
        container.mainContext.insert(Movie(title: "Pulp Fiction", genre: Genre(rawValue: 5)!))
        container.mainContext.insert(Movie(title: "The Lord of the Rings", genre: Genre(rawValue: 1)!))
        
        return container
    }
}
