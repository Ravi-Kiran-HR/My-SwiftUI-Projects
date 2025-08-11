//
//  ButtonImageView.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import SwiftUI

struct ButtonImageView: View {
    let symblName: String
    
    var body: some View {
        Image(systemName: symblName)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.purple.gradient)
            .padding(8)
            .background(
                Circle()
                    .fill(.ultraThickMaterial)
            )
            .frame(width: 80)
    }
}

#Preview {
    ButtonImageView(symblName: "plus.circle.fill")
}
