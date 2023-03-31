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
    products: [.dynamicLibrary],
    dependencies: []
)
