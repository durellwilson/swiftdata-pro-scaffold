import SwiftData
import Foundation

@Model
final class BaseEntity {
    var id: UUID
    var createdAt: Date
    var updatedAt: Date
    
    init() {
        self.id = UUID()
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

@Model
final class Task: BaseEntity {
    var title: String
    var isCompleted: Bool
    var priority: Priority
    var tags: [Tag]
    
    init(title: String, priority: Priority = .medium) {
        self.title = title
        self.isCompleted = false
        self.priority = priority
        self.tags = []
        super.init()
    }
    
    enum Priority: String, Codable {
        case low, medium, high, urgent
    }
}

@Model
final class Tag {
    var name: String
    var color: String
    var tasks: [Task]
    
    init(name: String, color: String = "#007AFF") {
        self.name = name
        self.color = color
        self.tasks = []
    }
}
