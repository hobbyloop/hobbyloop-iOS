import ProjectDescription
import ProjectDescriptionHelpers


let domain = Project.makeModule(
    name: "HPDomain",
    products: [.framework(.dynamic)],
    dependencies: []
)
