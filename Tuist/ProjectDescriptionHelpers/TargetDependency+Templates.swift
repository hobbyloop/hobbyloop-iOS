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
    }
    
    public struct ThirdParty {
        public struct Reactive {}
        public struct UI {}
        public struct Network {}
    }
}


extension TargetDependency.Project.Core {
    public static let thirdParty: TargetDependency = .project(
        target: "HPThirdParty",
        path: .relativeToRoot("Core/HPThirdParty")
    )
}


extension TargetDependency.ThirdParty.Reactive {
    public static let rxCocoa: TargetDependency = .external(name: "RxCocoa")
    public static let reactorKit: TargetDependency = .external(name: "ReactorKit")
}

extension TargetDependency.ThirdParty.UI {
    public static let snapKit: TargetDependency = .external(name: "SnapKit")
    public static let then: TargetDependency = .external(name: "Then")
}


extension TargetDependency.ThirdParty.Network {
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
    
}
