import ProjectDescription
import ProjectDescriptionHelpers


let foundation = Project.makeModule(
    name: "HPFoundation",
    products: [.framework(.dynamic)],
    dependencies: []
)
