//
//  GradientButtonStyle.swift
//  Hike
//
//  Created by Ravi Kiran HR on 18/06/25.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(
                configuration.isPressed ?
                LinearGradient(colors: [.customGrayMedium,
                                        .customGrayLight],
                               startPoint: .top,
                               endPoint: .bottom)
                :
                LinearGradient(colors: [.customGrayLight,
                                        .customGrayMedium],
                               startPoint: .top,
                               endPoint: .bottom)
                )
            .cornerRadius(40)
    }
}
