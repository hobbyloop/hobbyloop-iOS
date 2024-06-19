import ProjectDescription
import ProjectDescriptionHelpers

let network = Project.makeModule(
    name: "HPNetwork",
    products: [.framework(.dynamic)],
    dependencies: [
        .Project.Core.foundation,
        .Project.Core.common,
        .Project.Core.domain,
        .Project.Core.extensions,
        .Project.Core.thirdParty
    ]
)
