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
    name: "Hobbyloop",
    bundleId: "com.sideproj.Hobbyloop",
    products: [.app, .unitTests, .uiTests],
    infoExtensions: [:],
    dependencies: [
        .Project.Core.thirdParty,
        .Project.Core.foundation,
        .Project.UI.common
    ]
)
