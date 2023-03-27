// swift-tools-version: 5.7

///
import PackageDescription

///
let package = Package(
    name: "CompleteDictionary-module",
    products: [
        .library(
            name: "CompleteDictionary-module",
            targets: ["CompleteDictionary-module"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/jeremyabannister/FoundationToolkit",
            from: "0.4.9"
        ),
    ],
    targets: [
        .target(
            name: "CompleteDictionary-module",
            dependencies: [
                "FoundationToolkit",
            ]
        ),
        .testTarget(
            name: "CompleteDictionary-tests",
            dependencies: [
                "CompleteDictionary-module",
                .product(
                    name: "FoundationTestToolkit",
                    package: "FoundationToolkit"
                ),
            ]
        ),
    ]
)
