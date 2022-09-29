// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteProctoringBackend",
    platforms: [
        .iOS(.v16),.macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteProctoringBackend",
            targets: ["RemoteProctoringBackend"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
                .package(name: "Apollo",url:"https://github.com/apollographql/apollo-ios.git", .upToNextMinor(from: "0.50.0")),
                .package(name: "LiveKit",url:"https://github.com/livekit/client-sdk-swift.git", .upToNextMajor(from: "1.0.0")),
                .package(
                  url: "https://github.com/apple/swift-collections.git",
                  .upToNextMajor(from: "1.0.2") // or `.upToNextMinor
                ),
                .package(name: "RemoteProctoringModel", path: "../RemoteProctoringModel")
                
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteProctoringBackend",
            dependencies: [
                "LiveKit", "Apollo", .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "ApolloSQLite", package: "Apollo"),
                "RemoteProctoringModel"
            ]),
    ]
)
