//
//  EditPetView.swift
//  Paws
//
//  Created by Ravi Kiran HR on 21/06/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    @Binding var pet: Pet
    @State var photoPickerItem: PhotosPickerItem? = nil
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            // MARK:  - IMAGE
            if let imageData = pet.photo {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                        .padding(.top)
                }
            } else {
                CustomContentUnavailableView(icon: "pawprint.circle",
                                             title: "No Photo",
                                             description: "Add a photo of your pet")
                .padding(.top)
            }
            
            // MARK: - PHOTO PICKER
            PhotosPicker(selection: $photoPickerItem, matching: .images) {
                Label("Add Photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)

            // MARK: - TEXT FIELD
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            
            // MARK: - BUTTON
            Button {
               dismiss()
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .padding(8)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
            
        }//: Form
        .listStyle(.plain)
        .navigationBarTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: photoPickerItem) {
            Task {
                pet.photo = try? await photoPickerItem?.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    NavigationStack {
        let container = try? ModelContainer(for: Pet.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        EditPetView(pet: .constant(Pet(name: "Daisy123"))).modelContainer(container!)
    }
}





