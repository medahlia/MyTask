import SwiftUI
import SwiftData

struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Task.createdAt, order: .reverse)
    private var tasks: [Task]
    
    
    var body: some View {
        NavigationStack {
            List {
                if tasks.isEmpty {
                    //ContentUnavailableView()
                } else {
                    ForEach(tasks) { task in
                        TaskRowView(task: task)
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        //AddTaskView()
                    } label: {
                        Label("Add task",  systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}


#Preview {
    TasksView()
        .modelContainer(for: [Task.self, Category.self], inMemory: true)
}
