//
//  ContentView.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Properties
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Movie.title, order: .forward) var movies: [Movie]
    
    @State private var isSheetPresented: Bool = false
    @State private var isShowingAlert: Bool = false
    @State private var randomMovie: String = ""
    
    private func randomMovieGenerator() {
        randomMovie = movies.randomElement()?.title ?? ""
    }
    
  
    var body: some View {
        List {
            if !movies.isEmpty {
                Section(header:
                            VStack {
                    Text("Watchlist")
                        .font(.largeTitle.weight(.black))
                        .foregroundStyle(.purple.gradient)
                        .padding()
                    
                    HStack {
                        Label("Title", systemImage: "movieclapper")
                            .foregroundStyle(.purple)
                            .font(.headline.weight(.medium))
                        Spacer()
                        Label("Genre", systemImage: "tag")
                            .foregroundStyle(.purple)
                            .font(.headline.weight(.medium))
                    }
                }
                ) {
                    ForEach(movies) { movie in
                        HStack {
                            Text(movie.title)
                                .font(.title.weight(.light))
                                .padding(.vertical, 2)
                            
                            Spacer()
                            
                            Text(movie.genre.name)
                                .font(.footnote.weight(.medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule()
                                        .fill(Color.purple.gradient.opacity(0.9))
                                        .stroke(Color.purple.opacity(0.5), lineWidth: 1)
                                )
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive)  {
                                withAnimation {
                                    modelContext.delete(movie)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
        }
        .overlay {
            if movies.isEmpty {
                EmptyListView()
            }
        }
        // MARK: - Safe Area
        .safeAreaInset(edge: .bottom, alignment: .center) {
            HStack
            {
                if movies.count >= 2 {
                    // New Randomize Button
                    Button {
                        isShowingAlert = true
                        randomMovieGenerator()
                    } label: {
                        ButtonImageView(symblName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                    }
                    .alert(randomMovie, isPresented: $isShowingAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    .accessibilityLabel("Random Moview")
                    .sensoryFeedback(.success, trigger: isShowingAlert)
                    Spacer()
                }
                
                // New Movie Button
                Button {
                    isSheetPresented.toggle()
                } label: {
                    ButtonImageView(symblName: "plus.circle.fill")
                }
                .accessibilityLabel("New Movie")
                .sensoryFeedback(.success, trigger: isSheetPresented)
            }
            .padding(.horizontal)
        }
        
        .sheet(isPresented: $isSheetPresented) {
            NewMovieForm()
        }
        
    }
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Movie.self, inMemory: true)
}


#Preview("Sample List") {
    ContentView()
        .modelContainer(Movie.preview)
}
