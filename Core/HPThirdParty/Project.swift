//
//  Project.swift
//  Config
//
//  Created by Kim dohyun on 2023/03/31.
//

import ProjectDescription
import ProjectDescriptionHelpers

let thirdParty = Project.makeModule(
    name: "HPThirdParty",
    products: [.framework(.dynamic)],
    dependencies: [
        .ThirdParty.Reactive.reactorKit,
        .ThirdParty.Reactive.rxCocoa,
        .ThirdParty.Reactive.rxGesture,
        .ThirdParty.UI.then,
        .ThirdParty.UI.snapKit,
        .ThirdParty.UI.tabMan,
        .ThirdParty.Network.alamofire,
        .ThirdParty.SDK.kakao,
        .ThirdParty.SDK.google,
        .ThirdParty.Util.cryptoSwift
    ]
)
