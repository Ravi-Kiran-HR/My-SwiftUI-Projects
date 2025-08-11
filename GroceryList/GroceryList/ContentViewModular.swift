
import SwiftUI
import SwiftData
import TipKit

struct ContentViewModular: View {
    @Environment(\.modelContext) private var modelContext
    // @Query private var items: [Item] // Unsorted fetch
    @Query(sort: \Item.title, order: .forward) private var items: [Item] // sorted fetch

    @State private var item: String = ""
    @FocusState private var isFocused: Bool
    let buttonTip = ButtonTip()
    
    init() {
        setupTips()
    }
    
    func setupTips() {
        do {
            try Tips.resetDatastore()
            Tips.showAllTipsForTesting()
            try Tips.configure([.displayFrequency(.immediate)])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEssentialFoods() {
        let essentials = [
            Item(title: "Apples", isComplete: true),
            Item(title: "Bananas", isComplete: .random()),
            Item(title: "Oranges"),
            Item(title: "Milk"),
            Item(title: "Bread", isComplete: .random()),
            Item(title: "Eggs")
        ]
        essentials.forEach { modelContext.insert($0) }
        // print(modelContext.sqliteCommand)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ItemRowView(item: item)
                }
            }
            .overlay {
                if items.isEmpty {
                    EmptyListView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                AddItemView(item: $item, isFocused: _isFocused, modelContext: modelContext)
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if items.isEmpty {
                    EssentialFoodsToolbar(addAction: addEssentialFoods, tip: buttonTip)
                }
            }
        }
    }
}

struct ItemRowView: View {
    @Bindable var item: Item
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Text(item.title)
            .font(.title2.weight(.light))
            .padding(.vertical, 2)
            .foregroundStyle(item.isComplete ? Color.accentColor : Color.primary)
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

struct EmptyListView: View {
    var body: some View {
        ContentUnavailableView("Empty List", systemImage: "cart.circle", description: Text("Add your first item to the list."))
    }
}

struct AddItemView: View {
    @Binding var item: String
    @FocusState var isFocused: Bool
    var modelContext: ModelContext
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("Enter Item Name", text: $item)
                .padding(12)
                .background(.tertiary)
                .cornerRadius(12)
                .font(.title3.weight(.light))
                .focused($isFocused)
            
            Button {
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
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.extraLarge)
            .tint(.purple)
        }
        .padding()
        .background(.bar)
    }
}

struct EssentialFoodsToolbar: ToolbarContent {
    let addAction: () -> Void
    let tip: ButtonTip
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: addAction) {
                Image(systemName: "carrot")
            }
            .popoverTip(tip)
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
