//
//  PageModel.swift
//  Pinch
//
//  Created by Ravi Kiran HR on 30/08/25.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}


extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
