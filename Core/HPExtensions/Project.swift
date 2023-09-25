import ProjectDescription
import ProjectDescriptionHelpers


let extensions = Project.makeModule(
    name: "HPExtensions",
    products: [.framework(.static)],
    dependencies: [
        .Project.Core.thirdParty,
    ]
)
