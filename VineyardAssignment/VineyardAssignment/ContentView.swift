import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @State private var showingAlert = false
    @State private var newListName = ""

    var body: some View {
        NavigationStack {
            List(viewModel.lists) { list in
                // TODO: Use a NavigationLink to select a list.
                NavigationLink(destination: ListDetailView(list: list)) {
                    Text(list.name)
                }
            }
            .navigationTitle("Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("New List", isPresented: $showingAlert) {
                VStack {
                    Text("What is the name of the new list?")
                    TextField("List Name", text: $newListName)
                }
                Button("Create", action: {
                    viewModel.createList(name: newListName)
                    newListName = ""
                })
                Button("Cancel", role: .cancel, action: {
                    newListName = ""
                })
            }
        }
    }

    struct ListDetailView: View {
        @Environment(ViewModel.self) private var viewModel
        var list: ItemList
        
        @State private var newItemName: String = ""
        @State private var showingAlert = false

        var body: some View {
            VStack {
                List {
                    ForEach(list.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.toggleItemAsCompleted(item, list: list)
                                }
                        }
                    }
                }
                
                Button(action: {
                    showingAlert = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Item")
                    }
                }
                .padding()
                .alert("New Item", isPresented: $showingAlert) {
                    VStack {
                        Text("Enter the name of the new item:")
                        TextField("Item Name", text: $newItemName)
                    }
                    Button("Create", action: {
                        viewModel.addItem(to: list, name: newItemName)
                        newItemName = ""
                    })
                    Button("Cancel", role: .cancel, action: {
                        newItemName = ""
                    })
                }
            }
            .navigationTitle(list.name)
        }
    }
}

#Preview {
    ContentView()
}