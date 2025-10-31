// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftDataProScaffold",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "SwiftDataProScaffold", targets: ["SwiftDataProScaffold"]),
    ],
    targets: [
        .target(name: "SwiftDataProScaffold"),
    ]
)
