//
//  WishModel.swift
//  Wishlist
//
//  Created by Ravi Kiran HR on 19/06/25.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
