
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "VulnerableSwiftProject",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        // Vulnerable swift-nio-http2 version (DoS via ALTSVC/ORIGIN)
        .package(url: "https://github.com/apple/swift-nio-http2.git", .exact("1.18.0")),

        // Vulnerable swift-nio-ssl version (executable stack RCE)
        .package(url: "https://github.com/apple/swift-nio-ssl.git", .exact("2.0.0")),

        // Potentially vulnerable SwiftJWT (older versions had JWT verification issues)
        .package(url: "https://github.com/Kitura/Swift-JWT.git", .exact("3.6.200")),

        // Outdated version of SwiftLog (older logging implementations with edge-case overflow bugs)
        .package(url: "https://github.com/apple/swift-log.git", .exact("1.0.0")),

        // Old CryptoSwift version with known timing attacks and side-channel issues
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .exact("1.3.1"))
    ],
    targets: [
        .executableTarget(
            name: "VulnerableSwiftProject",
            dependencies: [
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "NIOSSL", package: "swift-nio-ssl"),
                .product(name: "SwiftJWT", package: "Swift-JWT"),
                .product(name: "Logging", package: "swift-log"),
                "CryptoSwift"
            ]
        )
    ]
)
