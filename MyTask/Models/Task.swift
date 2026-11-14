import Foundation
import SwiftData


@Model
final class Task {
    var id: UUID
    var title: String
    var notes: String
    
    var createdAt: Date
    var dueDate: Date?
    var completedAt: Date?
    
    var priority: String
    
    var category: Category? // not optional
    
    var isCompleted: Bool { completedAt != nil } 
    
    init(title: String, notes: String = "", dueDate: Date? = nil,
         priority: String = "medium", category: Category? = nil) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.createdAt = Date()
        self.dueDate = dueDate
        self.completedAt = nil
        self.priority = priority
        self.category = category
    }
}
