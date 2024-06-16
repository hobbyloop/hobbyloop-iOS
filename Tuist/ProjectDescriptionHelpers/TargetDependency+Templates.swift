//
//  TargetDependency+Templates.swift
//  Config
//
//  Created by Kim dohyun on 2023/03/31.
//

import ProjectDescription
import ProjectDescriptionHelpers


extension TargetDependency {
    public struct Project {
        public struct Core {}
        public struct UI {}
    }
    
    public struct ThirdParty {
        public struct Reactive {}
        public struct UI {}
        public struct Network {}
        public struct SDK {}
        public struct Util {}
    }
}


extension TargetDependency.Project.Core {
    public static let thirdParty: TargetDependency = .project(
        target: "HPThirdParty",
        path: .relativeToRoot("Core/HPThirdParty")
    )
    
    public static let common: TargetDependency = .project(
        target: "HPCommon",
        path: .relativeToRoot("Core/HPCommon")
    )
    
    public static let network: TargetDependency = .project(
        target: "HPNetwork",
        path: .relativeToRoot("Core/HPNetwork")
    )
    
    public static let extensions: TargetDependency = .project(
        target: "HPExtensions",
        path: .relativeToRoot("Core/HPExtensions")
    )
    
    public static let foundation: TargetDependency = .project(
        target: "HPFoundation",
        path: .relativeToRoot("Core/HPFoundation")
    )
    
    public static let domain: TargetDependency = .project(
        target: "HPDomain",
        path: .relativeToRoot("Core/HPDomain")
    )
    
}


extension TargetDependency.Project.UI {
    public static let common: TargetDependency = .project(
        target: "HPCommonUI",
        path: .relativeToRoot("UI/HPCommonUI")
    )
}


extension TargetDependency.ThirdParty.Reactive {
    public static let rxCocoa: TargetDependency = .external(name: "RxCocoa")
    public static let reactorKit: TargetDependency = .external(name: "ReactorKit")
    public static let rxGesture: TargetDependency = .external(name: "RxGesture")
    public static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
}

extension TargetDependency.ThirdParty.UI {
    public static let snapKit: TargetDependency = .external(name: "SnapKit")
    public static let then: TargetDependency = .external(name: "Then")
    public static let tabMan: TargetDependency = .external(name: "Tabman")
}


extension TargetDependency.ThirdParty.Network {
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
}

extension TargetDependency.ThirdParty.SDK {
    public static let kakao: TargetDependency = .external(name: "RxKakaoSDKUser")
    public static let google: TargetDependency = .external(name: "GoogleSignIn")
}


extension TargetDependency.ThirdParty.Util {
    public static let keychainAccess: TargetDependency = .external(name: "KeychainAccess")
    public static let cryptoSwift: TargetDependency = .external(name: "CryptoSwift")
}
