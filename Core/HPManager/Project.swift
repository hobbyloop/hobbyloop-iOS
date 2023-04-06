import ProjectDescription
import ProjectDescriptionHelpers


let manager = Project.makeModule(
    name: "HPManager",
    products: [.framework(.static)],
    dependencies: [
        .Project.Core.domain,
        .Project.Core.extensions
    ]
)
