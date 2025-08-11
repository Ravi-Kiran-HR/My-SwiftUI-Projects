//
//  Pet.swift
//  Paws
//
//  Created by Ravi Kiran HR on 21/06/25.
//

import Foundation
import SwiftData

@Model
final class Pet: Identifiable {
    var id: UUID = UUID()
    var createdAt: Date = Date()

    var name: String
    @Attribute(.externalStorage) var photo: Data?

    init (name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: config)
        
        container.mainContext.insert(Pet(name: "Rexy"))
        container.mainContext.insert(Pet(name: "Bella"))
        container.mainContext.insert(Pet(name: "Charlie"))
        container.mainContext.insert(Pet(name: "Daisy"))
        container.mainContext.insert(Pet(name: "Fido"))
        container.mainContext.insert(Pet(name: "Gus"))
        container.mainContext.insert(Pet(name: "Mimi"))
        container.mainContext.insert(Pet(name: "Luna"))
        
        return container
    }
}
