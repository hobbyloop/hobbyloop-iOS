import ProjectDescription
import ProjectDescriptionHelpers


let extensions = Project.makeModule(
    name: "HPExtensions",
    products: [.framework(.dynamic)],
    dependencies: [
        .Project.Core.thirdParty
    ]
)
