import ProjectDescription
import ProjectDescriptionHelpers


let foundation = Project.makeModule(
    name: "HPFoundation",
    products: [.framework(.dynamic)],
    dependencies: [
        .Project.Core.extensions,
        .Project.Core.common,
        .Project.Core.manager
    ]
)
