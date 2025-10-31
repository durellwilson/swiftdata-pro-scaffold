import SwiftData
import Foundation

struct QueryBuilder<T: PersistentModel> {
    private var predicate: Predicate<T>?
    private var sortDescriptors: [SortDescriptor<T>] = []
    private var limit: Int?
    
    func filter(_ predicate: Predicate<T>) -> Self {
        var copy = self
        copy.predicate = predicate
        return copy
    }
    
    func sort(by keyPath: KeyPath<T, some Comparable>, order: SortOrder = .forward) -> Self {
        var copy = self
        copy.sortDescriptors.append(SortDescriptor(keyPath, order: order))
        return copy
    }
    
    func limit(_ count: Int) -> Self {
        var copy = self
        copy.limit = count
        return copy
    }
    
    func build() -> FetchDescriptor<T> {
        var descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortDescriptors)
        if let limit = limit {
            descriptor.fetchLimit = limit
        }
        return descriptor
    }
}
