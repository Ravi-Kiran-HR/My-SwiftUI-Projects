//
//  CustomButtonView.swift
//  Hike
//
//  Created by Ravi Kiran HR on 17/06/25.
//

import SwiftUI

struct CustomButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.white, Color.customGreenLight,
                                              Color.customGreenMedium],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .stroke(LinearGradient(colors: [Color.customGrayLight,
                                                Color.customGrayMedium],
                                       startPoint: .top,
                                       endPoint: .bottom), lineWidth: 4)
            
            Image(systemName: "figure.hiking")
                .fontWeight(.black)
                .font(.system(size: 30))
                .foregroundStyle(LinearGradient(colors: [Color.customGrayLight,
                                                         Color.customGrayMedium],
                                                startPoint: .top,
                                                endPoint: .bottom))

            
        }
        .frame(width: 58, height: 58)
    }
}

#Preview {
    CustomButtonView()
}
