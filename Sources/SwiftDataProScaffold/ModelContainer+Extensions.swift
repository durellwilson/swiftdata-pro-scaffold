import SwiftData
import Foundation

extension ModelContainer {
    static func create(
        for models: [any PersistentModel.Type],
        inMemory: Bool = false,
        cloudSync: Bool = false
    ) -> ModelContainer {
        let schema = Schema(models)
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory,
            cloudKitDatabase: cloudSync ? .automatic : .none
        )
        return try! ModelContainer(for: schema, configurations: [config])
    }
}
