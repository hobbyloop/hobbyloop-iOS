//
//  Path+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/05/31.
//

import ProjectDescription
import ProjectDescriptionHelpers


public extension Path {
    struct CocoaPods {
        public struct Framework {}
    }
}


extension Path.CocoaPods.Framework {
    public static let naverLogin: Path = .relativeToRoot("Pods/naveridlogin-sdk-ios/NaverThirdPartyLogin.xcframework")
    public static let naverMap: Path = .relativeToRoot("Pods/NMapsMap/framework/NMapsMap.xcframework")
    public static let naverGeometry: Path = .relativeToRoot("Pods/NMapsGeometry/framework/NMapsGeometry.xcframework")
}



