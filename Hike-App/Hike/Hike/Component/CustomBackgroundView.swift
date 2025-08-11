//
//  CustomBackgroundView.swift
//  Hike
//
//  Created by Ravi Kiran HR on 17/06/25.
//

import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        ZStack {
            // Depth
            Color.customGreenDark
                .cornerRadius(40)
                .offset(y: 12)
            
            // Light
            Color.customGreenLight
                .cornerRadius(40)
                .offset(y: 3)
                .opacity(0.85)
            
            // Surface
            LinearGradient(colors: [Color.customGreenLight,
                                    Color.customGreenMedium],
                           startPoint: .top,
                           endPoint: .bottom)
            .cornerRadius(40)
        }
    }
}

#Preview {
    CustomBackgroundView()
        .padding()
}
