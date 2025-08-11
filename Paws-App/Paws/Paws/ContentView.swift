//
//  ContentView.swift
//  Paws
//
//  Created by Ravi Kiran HR on 21/06/25.
//

// Commented code in the bottem section of this file throws the compilar error due to the over use of  nested closures, below is the modular version of the same logic

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Pet.createdAt, order: .reverse) var pets: [Pet]
   // @State private var path = [Pet]()
    @State private var isEditing: Bool = false
    
    func addPet() {
        isEditing = false
        let newPet = Pet(name: "New Friend")
        modelContext.insert(newPet)
        //path = [newPet]
    }
    
    var body: some View {
        //        NavigationStack(path: $path) {
        NavigationStack {
            ScrollView {
                PetGridView(pets: pets, isEditing: $isEditing)
            }
            .navigationTitle(pets.isEmpty ? "" : "Paws")
            .navigationDestination(for: Pet.self) { pet in
                EditPetView(pet: .constant(pet))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a new Pet", systemImage: "plus.circle", action: addPet)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(
                        icon: "dog.circle",
                        title: "No Pets",
                        description: "Add a pet to get started"
                    )
                }
            }
        }
    }
}

struct PetGridView: View {
    let pets: [Pet]
    @Binding var isEditing: Bool
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120)),
    ]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(pets) { pet in
                NavigationLink(value: pet) {
                    PetTile(pet: pet, isEditing: $isEditing)
                }
                .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal)
    }
}

struct PetTile: View {
    let pet: Pet
    @Binding var isEditing: Bool
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if let imageData = pet.photo {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                }
            } else {
                Image(systemName: "pawprint.circle")
                    .resizable()
                    .scaledToFit()
                    .padding(40)
                    .foregroundStyle(.quaternary)
            }
            Spacer()
            Text(pet.name)
                .font(.title3.weight(.light))
                .padding(.vertical)
        }
        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 0, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
        .overlay(alignment: .topTrailing) {
            if isEditing {
                Menu {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        withAnimation {
                            modelContext.delete(pet)
                            try? modelContext.save()
                        }
                    }
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.red)
                        .symbolRenderingMode(.multicolor)
                        .padding()
                }
            }
        }
    }
}

#Preview("Sample Content") {
    ContentView()
        .modelContainer(Pet.preview)
}


#Preview("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}



//import SwiftUI
//import SwiftData
//
//struct ContentView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Pet.name, order: .forward) var pets: [Pet]
//
//    let layout = [
//        GridItem(.flexible(minimum: 120)),
//        GridItem(.flexible(minimum: 120))
//    ]
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: layout) {
//                    GridRow {
//                        ForEach(pets) { pet in
//                            NavigationLink {
//                                PetStack(pet: pet)
//                            }//: NavigationLink
//                        }//: ForEach
//                    }//: GridRow
//                }//: LazyVGrid
//            }//: ScrollView
//            .overlay {
//                if pets.isEmpty {
//                    CustomContentUnavailableView(icon: "dog.circle", title: "No Pets", description: "Add a pet to get started")
//                }
//            }
//        }//: NavigationStack
//    }
//}
//
//struct PetStack: View {
//    let pet: Pet
//    var body: some View {
//        VStack {
//            Spacer()
//            Text(pet.name)
//                .font(.title.weight(.light))
//                .padding(.vertical)
//        }//: VStack
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
//    }
//}
