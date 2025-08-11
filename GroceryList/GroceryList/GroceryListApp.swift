//
//  GroceryListApp.swift
//  GroceryList
//
//  Created by Ravi Kiran HR on 19/06/25.
//

import SwiftUI
import SwiftData

@main
struct GroceryListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewModular()
                .modelContainer(for: Item.self)
        }
    }
}


extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
