//
//  ControlImageView.swift
//  Pinch
//
//  Created by Ravi Kiran HR on 30/08/25.
//

import SwiftUI

struct ControlImageView: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))

    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
}
