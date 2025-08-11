//
//  ContentView.swift
//  GroceryList
//
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var item: String = ""
    @FocusState private var isFocused: Bool
    let buttonTip = ButtonTip()
    
    // this is only for testing the tips so that it apears always
    func setupTips() {
        do {
            try Tips.resetDatastore()
            Tips.showAllTipsForTesting()
            try Tips.configure([
                .displayFrequency(.immediate)
            ])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    init() {
        //        try? Tips.configure()
        // below code is only for testing the tips so that it apears always otherwise use above code
        setupTips()
    }
    
    func addEssentialFoods() {
        modelContext.insert(Item(title: "Apples", isComplete: true))
        modelContext.insert(Item(title: "Bananas", isComplete: .random()))
        modelContext.insert(Item(title: "Oranges"))
        modelContext.insert(Item(title: "Milk"))
        modelContext.insert(Item(title: "Bread", isComplete: .random()))
        modelContext.insert(Item(title: "Eggs"))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title2.weight(.light))
                        .padding(.vertical, 2)
                        .foregroundStyle(item.isComplete ? Color.accentColor :  Color.primary)
                        .strikethrough(item.isComplete)
                        .italic(item.isComplete)
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isComplete ? "xmark.circle.fill" : "checkmark.circle") {
                                item.isComplete.toggle()
                            }
                            .tint(item.isComplete ? .accentColor : .green)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(item)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty List", systemImage: "cart.circle", description: Text("Add your first item to the list."))
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    let textField = TextField("Enter Item Name", text: $item)
                        .padding(12)
                        .background(.tertiary)
                    
                    textField
                        .cornerRadius(12)
                        .font(.title3.weight(.light))
                        .focused($isFocused)
                    
                    let button = Button {
                        guard !item.isEmpty else { return }
                        let newItem = Item(title: item, isComplete: false)
                        modelContext.insert(newItem)
                        item = ""
                        isFocused = false
                    } label: {
                        Text("Add Item")
                            .font(.title.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                        .buttonStyle(.borderedProminent)
                    
                    button
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.extraLarge)
                        .tint(.purple)
                }
                .padding()
                .background(.bar)
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEssentialFoods()
                        } label: {
                            Image(systemName: "carrot")
                        }
                        .popoverTip(buttonTip)
                    }
                }
            }
        }
    }
}


#Preview("Sample List") {
    let sampleData = [
        Item(title: "Apples", isComplete: true),
        Item(title: "Bananas", isComplete: .random()),
        Item(title: "Oranges"),
        Item(title: "Milk"),
        Item(title: "Bread", isComplete: .random()),
        Item(title: "Eggs"),
    ]
    
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for item in sampleData {
        container.mainContext.insert(item)
    }
    
    return ContentView()
        .modelContainer(container)
}


#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
