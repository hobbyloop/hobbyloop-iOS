import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains HobbyloopIOS App target and HobbyloopIOS unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.makeModule(
    name: "hobbyloop",
    bundleId: "com.app.hobbyloop",
    products: [.app, .unitTests, .uiTests],
    infoExtensions: [:],
    dependencies: [
        .Project.Core.thirdParty,
        .Project.Core.common,
        .Project.Core.domain,
        .Project.Core.network,
        .Project.UI.common
    ], externalDependencies: [
        .xcframework(path: .CocoaPods.Framework.naverLogin),
        .xcframework(path: .CocoaPods.Framework.naverMap),
        .xcframework(path: .CocoaPods.Framework.naverGeometry)
        
    ]
)
