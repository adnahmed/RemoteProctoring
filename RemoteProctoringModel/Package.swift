// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteProctoringModel",
    platforms: [
        .iOS(.v16),.macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteProctoringModel",
            targets: ["RemoteProctoringModel"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Navajo-Swift", url: "https://github.com/Wistas23/Navajo-Swift.git", .upToNextMajor(from: "2.0.0")),
        .package(name: "KeychainAccess", url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteProctoringModel",
            dependencies: [
                "Navajo-Swift", "KeychainAccess"
            ]),
    ]
)
