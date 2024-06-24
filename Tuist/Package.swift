// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Hobbyloop",
    dependencies: [
        .reactorKit,
        .rxSwift,
        .rxGesture,
        .rxDataSources,
        .snapKit,
        .then,
        .tabMan,
        .alamofire,
        .kakaoSDK,
        .googleSDK,
        .cryptoSwift,
        .keychainAccess,
        .firebase
    ]
)

extension PackageDescription.Package.Dependency {
    private static func remote(repo: String, version: PackageDescription.Version) -> PackageDescription.Package.Dependency {
        return Self.package(url: "https://github.com/\(repo).git", exact: version)
    }
}

extension PackageDescription.Package.Dependency {
    typealias Dependency = PackageDescription.Package.Dependency
    static let reactorKit = Dependency.remote(repo: "ReactorKit/ReactorKit", version: "3.2.0")
    static let rxSwift = Dependency.remote(repo: "ReactiveX/RxSwift", version: "6.5.0")
    static let rxGesture = Dependency.remote(repo: "RxSwiftCommunity/RxGesture", version: "4.0.3")
    static let rxDataSources = Dependency.remote(repo: "RxSwiftCommunity/RxDataSources", version: "5.0.0")
    static let snapKit = Dependency.remote(repo: "SnapKit/SnapKit", version: "5.6.0")
    static let then = Dependency.remote(repo: "devxoul/Then", version: "3.0.0")
    static let tabMan = Dependency.remote(repo: "uias/Tabman", version: "2.13.0")
    static let alamofire = Dependency.remote(repo: "Alamofire/Alamofire", version: "5.6.1")
    static let kakaoSDK = Dependency.remote(repo: "kakao/kakao-ios-sdk-rx", version: "2.15.0")
    static let googleSDK = Dependency.remote(repo: "google/GoogleSignIn-iOS", version: "6.0.2")
    static let cryptoSwift = Dependency.remote(repo: "krzyzanowskim/CryptoSwift", version: "1.7.1")
    static let keychainAccess = Dependency.remote(repo: "kishikawakatsumi/KeychainAccess", version: "4.2.2")
    static let firebase = Dependency.remote(repo: "firebase/firebase-ios-sdk", version: "8.6.0")
}
