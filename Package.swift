// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-api-inventory",
    products: [
        .executable(name: "swift-api-inventory", targets: ["swift-api-inventory"])
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftDocOrg/swift-doc.git", .revision("f852a149365e2ece4417b4e1ffc4d1094b644cb7")),
        .package(url: "https://github.com/SwiftDocOrg/SwiftSemantics.git", .upToNextMinor(from: "0.0.2")),
        .package(url: "https://github.com/kylef/Commander.git", .upToNextMinor(from: "0.9.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "swift-api-inventory",
            dependencies: ["SwiftDoc", "SwiftSemantics", "Commander"]
        ),
    ]
)
