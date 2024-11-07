//
//  ContentView.swift
//  TodoApp
//
//  Created by Abhijith Chalil on 23/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Todo.isCompleted) private var toDos: [Todo]
    @State private var isAlertShowing = false
    @State private var toDoTitle = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) {toDo in
                    HStack {
                        Button{
                            toDo.isCompleted.toggle()
                        }label: {
                            Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        Text(toDo.title)
                    }
                }.onDelete(perform: deleteTodos)
            }.navigationTitle("ToDo App").toolbar {
                Button(action: {
                    isAlertShowing.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }.alert("Add Todo", isPresented: $isAlertShowing, actions: {
                TextField("Enter Todo", text: $toDoTitle)
                Button{
                    modelContext.insert(Todo(title: toDoTitle, isCompleted: false))
                    
                }label: {
                    Text("Add")
                }
            }).overlay {
                if toDos.isEmpty{
                    ContentUnavailableView("Nothing to do here", systemImage: "checkmark.circle.fill")
                }}
        }
    }
    
    func deleteTodos(_ indexSet: IndexSet){
        for index in indexSet {
            let toDo = toDos[index]
            modelContext.delete(toDo)
        }
    }
}

#Preview {
    ContentView()
}
