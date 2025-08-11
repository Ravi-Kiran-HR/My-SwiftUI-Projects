//
//  Item.swift
//  GroceryList
//
//  Created by Ravi Kiran HR on 19/06/25.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isComplete: Bool = false
    var createdAt: Date = Date()

    init(title: String, isComplete: Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
}
