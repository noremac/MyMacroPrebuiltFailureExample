// swift-tools-version: 6.1

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "MyMacro",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "MyMacro",
      targets: ["MyMacro"]
    ),
    .executable(
      name: "MyMacroClient",
      targets: ["MyMacroClient"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "601.0.1"),
    .package(url: "https://github.com/pointfreeco/swift-macro-testing", from: "0.6.3"),
  ],
  targets: [
    .macro(
      name: "MyMacroMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),

    .target(name: "MyMacro", dependencies: ["MyMacroMacros"]),
    .executableTarget(name: "MyMacroClient", dependencies: ["MyMacro"]),
    .testTarget(
      name: "MyMacroTests",
      dependencies: [
        "MyMacroMacros",
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
  ]
)
