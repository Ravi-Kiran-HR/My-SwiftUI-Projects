//
//  NewMovieForm.swift
//  WatchList
//
//  Created by Ravi Kiran HR on 23/06/25.
//

import SwiftUI

struct NewMovieForm: View {
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var selectedGenre: Genre = .action
    
    // MARK: - FUNCTIONS
    private func addMovie() {
        let newMovie = Movie(title: title, genre: selectedGenre)
        modelContext.insert(newMovie)
        title = ""
        selectedGenre = .action
    }
    
    var body: some View {
        Form {
            List {
                // MARK: - HEADER
                Text("What to watch")
                    .font(.largeTitle.weight(.black))
                    .foregroundStyle(.purple.gradient)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                
                // MARK: - TITLE
                TextField("Movie Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .font(.largeTitle.weight(.light))
                    
                
                // MARK: - GENRE
                Picker("Genre", selection: $selectedGenre) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.name)
                            .tag(genre)
                    }
                }
    
                // MARK: - SAVE BUTTON
                Button {
                    if !title.isEmpty || !title.trimmingCharacters(in: .whitespaces).isEmpty {
                        addMovie()
                        dismiss()
                    }
                }label: {
                    Text("Save")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
                .buttonBorderShape(.roundedRectangle)
                .disabled(title.isEmpty || title.trimmingCharacters(in: .whitespaces).isEmpty)
                
                // MARK: - CANCEL BUTTON
                Button {
                    title = ""
                    selectedGenre = .action
                    dismiss()
                }label: {
                    Text("Cancel")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.extraLarge)
                .buttonBorderShape(.roundedRectangle)
            }
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    NewMovieForm()
}
