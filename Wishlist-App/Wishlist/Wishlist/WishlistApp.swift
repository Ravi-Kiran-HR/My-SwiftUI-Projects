//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Ravi Kiran HR on 19/06/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for : Wish.self)
        }
    }
}
