// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModularizedAppKit",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ModularizedAppKit",
            targets: ["ModularizedAppKit"]),
    ],
    targets: [
        .target(name: "RepositoryDetails", dependencies: []),
        .target(name: "Networking", dependencies: []),
        .target(name: "ModularizedAppKit", dependencies: [
            .targetItem(name: "Networking", condition: nil),
            .targetItem(name: "RepositoryDetails", condition: nil)
        ])
    ]
)
