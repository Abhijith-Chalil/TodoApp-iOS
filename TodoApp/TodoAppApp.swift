//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Abhijith Chalil on 23/10/24.
//

import SwiftUI
import SwiftData

@main
struct TodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Todo.self)
    }
}


@Model class Todo {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}


extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self)-> Bool {
        !lhs && rhs
    }
}

