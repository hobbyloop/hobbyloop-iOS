import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func makeModule(
        name: String,
        bundleId: String = "",
        products: [HPProduct],
        infoExtensions: [String: InfoPlist.Value] = [:],
        settings: Settings? = .default,
        packages: [ProjectDescription.Package] = [],
        testDependencies: [TargetDependency] = [],
        dependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = []
        var schemes: [Scheme] = []
        
        var infoPlist: InfoPlist = .base(name: name)
        
        
        if products.contains(.app) {
            let appTarget: Target = .init(
                name: name,
                platform: .iOS,
                product: .app,
                bundleId: bundleId.isEmpty ? "com.sideproj.\(name)" : bundleId,
                deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                scripts: [],
                dependencies: dependencies,
                settings: settings
            )
            targets.append(appTarget)
        }
        
        let appScheme: Scheme = .init(
            name: name,
            shared: true,
            hidden: false,
            buildAction: .init(targets: ["\(name)"]),
            runAction: .runAction(executable: "\(name)")
        )
        
        
        if products.contains(.unitTests) {
          
          var dependencies: [TargetDependency] = [.target(name: name), .xctest]
          dependencies += testDependencies
          
          let target: Target = .init(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.sideproj.\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)Tests/**"],
            resources: ["\(name)Tests/**"],
            dependencies: dependencies
          )
          targets.append(target)
        }
        
        if products.contains(.uiTests) {
          let target: Target = .init(
            name: "\(name)UITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "com.sideproj.\(name)UITests",
            sources: "\(name)UITests/**",
            dependencies: [.target(name: name)]
          )
          targets.append(target)
        }
        
        
        if products.filter({ $0.isLibrary}).count != 0 {
            let libraryTarget: Target = .init(
                name: name,
                platform: .iOS,
                product: products.contains(.library(.static)) ? .staticLibrary : .dynamicLibrary,
                bundleId: "com.sideproj.\(name)",
                deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: settings
            )
            
            targets.append(libraryTarget)
        }
        
        if products.filter({ $0.isFramework }).count != 0 {
            let frameworkTarget: Target = .init(
                name: name,
                platform: .iOS,
                product: products.contains(.framework(.static)) ? .staticFramework : .framework,
                bundleId: "com.sideproj.\(name)",
                deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: products.contains(.framework(.dynamic)) ? ["Resources/**"] : nil,
                dependencies: dependencies,
                settings: settings
            )
            
            targets.append(frameworkTarget)
        }
        
        schemes.append(appScheme)
        
        
        return Project(
            name: name,
            packages: packages,
            targets: targets,
            schemes: schemes
        )
    }
}
