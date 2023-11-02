//
//  Dependencies.swift
//  Config
//
//  Created by Kim dohyun on 2023/03/31.
//

import ProjectDescription
import ProjectDescriptionHelpers


let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies([
        Package.reactorKit,
        Package.rxSwift,
        Package.rxGesture,
        Package.rxDataSources,
        Package.snapKit,
        Package.then,
        Package.alamofire,
        Package.kakaoSDK,
        Package.googleSDK,
        Package.cryptoSwift,
        Package.keychainAccess,
        Package.tabMan
    ]),
    platforms: [.iOS]
)
