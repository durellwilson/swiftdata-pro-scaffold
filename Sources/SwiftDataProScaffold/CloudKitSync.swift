import SwiftData
import CloudKit

actor CloudKitSyncService {
    private let container: CKContainer
    
    init(identifier: String = "iCloud.com.yourapp") {
        self.container = CKContainer(identifier: identifier)
    }
    
    func syncStatus() async throws -> CKAccountStatus {
        try await container.accountStatus()
    }
    
    func enableSync() async throws {
        let status = try await syncStatus()
        guard status == .available else {
            throw SyncError.accountUnavailable
        }
    }
}

enum SyncError: Error {
    case accountUnavailable
    case syncFailed
}
