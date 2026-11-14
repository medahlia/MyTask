import SwiftUI
import SwiftData

struct AddTaskView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview("Add Task") {
    NavigationStack {
        AddTaskView()
    }
    .modelContainer(for: [Task.self, Category.self], inMemory: true)
}

#Preview("Add Task with Categories") {
    let container = try! ModelContainer(for: Task.self, Category.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    let context = container.mainContext

    context.insert(Category(name: "Робота", color: "blue", icon: "briefcase"))

    context.insert(Category(name: "Навчання", color: "purple", icon: "book"))

    context.insert(Category(name: "Особисте", color: "green", icon: "person"))

    return NavigationStack {
        AddTaskView()
    }
    .modelContainer(container)
}
