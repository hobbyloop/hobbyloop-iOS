import ProjectDescription
import ProjectDescriptionHelpers

let common = Project.makeModule(
    name: "HPCommonUI",
    products: [.framework(.dynamic)],
    dependencies: [
        .Project.Core.thirdParty
    ]
)
