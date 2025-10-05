
import Foundation
import NIO
import NIOHTTP2
import NIOSSL
import SwiftJWT
import Logging
import CryptoSwift

print("VulnerableSwiftProject running")

// HTTP/2 bootstrapping to trigger inclusion
let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
defer { try? group.syncShutdownGracefully() }
let _ = ServerBootstrap(group: group)

// SSL context setup to trigger swift-nio-ssl
_ = try? NIOSSLContext(configuration: TLSConfiguration.clientDefault)

// Dummy JWT to trigger SwiftJWT
struct MyClaims: Claims {
    let sub: String
}
var jwt = JWT(claims: MyClaims(sub: "user123"))
let signer = JWTSigner.hs256(key: Data("secret".utf8))
_ = try? jwt.sign(using: signer)

// Logging setup to trigger swift-log
let logger = Logger(label: "vuln.logger")
logger.info("This is a log message")

// CryptoSwift example (AES encryption)
let aes = try! AES(key: "passwordpassword".bytes, blockMode: ECB(), padding: .pkcs7)
let ciphertext = try! aes.encrypt("Sensitive data".bytes)
print("Encrypted: \(ciphertext)")
