//
//  WatchListApp.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import SwiftUI
import SwiftData

@main
struct WatchListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Movie.self)
        }
    }
}
