//
//  Package+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/04/05.
//

import ProjectDescription

private extension Package {
    private static func remote(repo: String, version: Version) -> Self {
        return Self.remote(url: "https://github.com/\(repo).git", requirement: .exact(version))
    }
}


public extension Package {
    static let reactorKit = Self.remote(repo: "ReactorKit/ReactorKit", version: "3.2.0")
    static let rxSwift = Self.remote(repo: "ReactiveX/RxSwift", version: "6.5.0")
    static let snapKit = Self.remote(repo: "SnapKit/SnapKit", version: "5.6.0")
    static let then = Self.remote(repo: "devxoul/Then", version: "3.0.0")
    static let alamofire = Self.remote(repo: "Alamofire/Alamofire", version: "5.6.1")
}
