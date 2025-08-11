//
//  EmptyListView.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ContentUnavailableView {
            Circle()
                .fill(.purple.gradient)
                .stroke(.purple.gradient.opacity(0.15), lineWidth: 30)
                .stroke(.purple.gradient.opacity(0.15), lineWidth: 60)
                .stroke(.purple.gradient.opacity(0.15), lineWidth: 90)
                .frame(width: 180)
                .overlay {
                    Image(systemName: "movieclapper")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(Color(UIColor.secondarySystemBackground))
                        .padding(.top, -6)
                        .symbolEffect(.breathe)
                }
                .padding(.bottom, 90)
        } description: {
            GroupBox {
                TabView {
                    PageTabView(icon: "1.circle", description: "Add some movies to your watchlist if you plan to watch them later")
                        .padding(.bottom, 36)
                    
                    PageTabView(icon: "2.circle", description: "Later on you can also choose a random film to watch")
                        .padding(.bottom, 36)
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(minWidth: 0, maxWidth: 560, minHeight: 120, maxHeight: 180)
            }
            .foregroundStyle(.purple.opacity(0.8))
        }
    }
}

#Preview("Light Theme") {
    EmptyListView()
}

#Preview("Dark Theme") {
    EmptyListView()
        .preferredColorScheme(.dark)
}
