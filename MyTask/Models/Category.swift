import Foundation
import SwiftData


@Model
final class Category {
    var id: UUID
    var name: String
    var color: String
    var icon: String
    
    init(name: String, color: String = "blue", icon: String = "folder") {
        self.id = UUID()
        self.name = name
        self.color = color
        self.icon = icon
    }
}
