// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteProctoringUI",
    platforms: [
        .iOS(.v16),.macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteProctoringUI",
            targets: [
                "RemoteProctoringUI"
            ]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Neumorphic",url:"https://github.com/costachung/neumorphic/", .upToNextMajor(from: "2.0.5")),
        .package(name: "Pow",url: "https://github.com/movingparts-io/Pow", branch: "main"),
        .package(name: "LiveKit",url:"https://github.com/livekit/client-sdk-swift.git", .upToNextMajor(from: "1.0.0")),
        .package(
          url: "https://github.com/apple/swift-collections.git",
          .upToNextMajor(from: "1.0.2") // or `.upToNextMinor
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteProctoringUI",
            dependencies: [
                "Neumorphic", "Pow", "LiveKit",
                .product(name: "OrderedCollections", package: "swift-collections")
            ]
        )
    ]
)
