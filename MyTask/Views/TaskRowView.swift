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

#Preview {
    let task = Task(title: "Complete laboratory work")
    task.completedAt = .now
    
    TaskRowView(task: task)
        .padding()
        .modelContainer(for: [Task.self, Category.self], inMemory: true)
}
