//
//  ContentView.swift
//  Wishlist
//
//  Created by Ravi Kiran HR on 19/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    @State private var isAlertShowing: Bool = false
    @State private var newWishTitle: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title3.weight(.regular))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }//: ForEach
            }//: List
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                if !wishes.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count == 1 ? "" : "es")")
                    }
                }
            }
            
            
            .alert("Create a new wish", isPresented: $isAlertShowing) {
             TextField("Enter a wish", text: $newWishTitle)
                Button {
                    modelContext.insert(Wish(title: newWishTitle))
                    isAlertShowing.toggle()
                    newWishTitle = ""
                } label: {
                    Text("Save")
                }
                
            }
            .navigationTitle("My Wishlist")
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("My Wishlist is empty", systemImage: "heart.circle", description: Text("Add your first wish to your wishlist."))
                }
            }
        }
    }
}

#Preview("Sample Wishlist") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Master SwiftUI"))
    container.mainContext.insert(Wish(title: "Master SwiftData"))
    container.mainContext.insert(Wish(title: "Master Data Structures"))
    container.mainContext.insert(Wish(title: "Master Algorithms"))
    container.mainContext.insert(Wish(title: "Master System Design"))
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty Wishlist") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
