import ProjectDescription
import ProjectDescriptionHelpers

let network = Project.makeModule(
    name: "HPNetwork",
    products: [.framework(.dynamic)],
    dependencies: [
        .Project.Core.foundation
    ]
)
