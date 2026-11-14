import SwiftUI
import SwiftData

struct TaskRowView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var task: Task
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                toggleComletion()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(task.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? .secondary : .primary)
                
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                
                if let category = task.category {
                    Label(category.name, systemImage: category.icon)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            if task.priority == "high" {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func toggleComletion() {
        if task.isCompleted {
            task.completedAt = nil
        } else {
            task.completedAt = Date()
        }
    }
}

#Preview("Active Task") {
    let container = try! ModelContainer(
        for: Task.self, Category.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )

    let category = Category(
        name: "Навчання",
        color: "purple",
        icon: "book"
    )

    let task = Task(
        title: "Finish SwiftUI project",
        notes: "Work on TaskFlow",
        priority: "high",
        category: category
    )

    container.mainContext.insert(category)
    container.mainContext.insert(task)

    return TaskRowView(task: task)
        .padding()
        .modelContainer(container)
}

#Preview("Completed Task") {
    let container = try! ModelContainer(
        for: Task.self, Category.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )

    let task = Task(
        title: "Complete laboratory work"
    )

    task.completedAt = .now
    container.mainContext.insert(task)

    return TaskRowView(task: task)
        .padding()
        .modelContainer(container)
}
