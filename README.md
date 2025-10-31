# SwiftData Pro Scaffold

Advanced SwiftData scaffold with CloudKit sync, query builders, and production patterns for iOS 18+ / macOS 15+.

## 🚀 Features

### Advanced SwiftData
- Base entity with timestamps
- Relationships and cascading
- Custom predicates
- Sort descriptors
- Fetch limits

### CloudKit Integration
- Automatic sync
- Account status checking
- Conflict resolution
- Offline support

### Query Builder
- Fluent API
- Type-safe predicates
- Chainable operations
- Reusable queries

### Model Actor
- Thread-safe operations
- Async/await API
- Batch operations
- Transaction support

## 📦 Installation

```swift
dependencies: [
    .package(url: "https://github.com/durellwilson/swiftdata-pro-scaffold.git", from: "1.0.0")
]
```

## 🎯 Quick Start

### 1. Setup Container

```swift
import SwiftUI
import SwiftData
import SwiftDataProScaffold

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            .create(
                for: [Task.self, Tag.self],
                cloudSync: true
            )
        )
    }
}
```

### 2. Use Query Builder

```swift
struct TaskList: View {
    @Query(
        QueryBuilder<Task>()
            .filter(#Predicate { $0.isCompleted == false })
            .sort(by: \.createdAt, order: .reverse)
            .limit(50)
            .build()
    ) var tasks: [Task]
    
    var body: some View {
        List(tasks) { task in
            Text(task.title)
        }
    }
}
```

### 3. Use Data Service

```swift
@Observable
final class TaskViewModel {
    private let dataService: DataService
    
    func loadTasks() async throws {
        let tasks = try await dataService.fetch(
            Task.self,
            predicate: #Predicate { $0.priority == .high },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
    }
    
    func addTask(_ title: String) async {
        let task = Task(title: title)
        await dataService.insert(task)
        try? await dataService.save()
    }
}
```

### 4. CloudKit Sync

```swift
let syncService = CloudKitSyncService()

// Check status
let status = try await syncService.syncStatus()

// Enable sync
try await syncService.enableSync()
```

## 🏗️ Architecture

### Base Entity Pattern
```swift
@Model
final class MyModel: BaseEntity {
    var customField: String
    
    init(customField: String) {
        self.customField = customField
        super.init()
    }
}
```

### Relationships
```swift
@Model
final class Project {
    var name: String
    @Relationship(deleteRule: .cascade) var tasks: [Task]
}

@Model
final class Task {
    var title: String
    var project: Project?
}
```

### Complex Queries
```swift
let descriptor = QueryBuilder<Task>()
    .filter(#Predicate { task in
        task.priority == .high &&
        task.isCompleted == false &&
        task.createdAt > Date().addingTimeInterval(-86400)
    })
    .sort(by: \.priority)
    .sort(by: \.createdAt, order: .reverse)
    .limit(20)
    .build()
```

## 🎨 Advanced Features

### Batch Operations
```swift
actor DataService {
    func batchInsert<T: PersistentModel>(_ models: [T]) async throws {
        for model in models {
            modelContext.insert(model)
        }
        try modelContext.save()
    }
}
```

### Migration
```swift
let schema = Schema([Task.self, Tag.self])
let config = ModelConfiguration(
    schema: schema,
    migrationPlan: MyMigrationPlan.self
)
```

### Undo/Redo
```swift
.modelContainer(
    for: [Task.self],
    isUndoEnabled: true
)
```

## 📱 Platform Support

- ✅ iOS 18+
- ✅ macOS 15+
- ✅ CloudKit sync
- ✅ Offline support

## 🎓 Best Practices

1. **Use @ModelActor** for background operations
2. **Enable CloudKit** for multi-device sync
3. **Add indexes** for frequently queried fields
4. **Use predicates** instead of filtering in memory
5. **Batch operations** for better performance

## 🤝 Contributing

Part of Detroit's Swift ecosystem. PRs welcome!

## 📝 License

MIT License

---

**Production-ready SwiftData patterns** 🚀
