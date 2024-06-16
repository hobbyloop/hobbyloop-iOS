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
        isExcludedFramework: Bool = false,
        infoExtensions: [String: Plist.Value] = [:],
        settings: Settings? = .default,
        packages: [ProjectDescription.Package] = [],
        testDependencies: [TargetDependency] = [],
        dependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = []
        var schemes: [Scheme] = []
        
        let infoPlist: InfoPlist = .base(name: name)
        
        let targetSettings: Settings = .settings(
            base: [
                "OTHER_LDFLAGS": "-ObjC",
                "HEADER_SEARCH_PATHS": ["$(inherited) $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GoogleSignIn/Sources/Public $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/AppAuth-iOS/Source/AppAuth $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/AppAuth-iOS/Source/AppAuthCore $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/gtm-session-fetcher/Source/SwiftPackage $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GoogleSignIn/Sources/../../ $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GTMAppAuth/GTMAppAuth/Sources/Public/GTMAppAuth"],
                "MARKETING_VERSION": "1.0",
                "CURRENT_PROJECT_VERSION": "1",
                "VERSIONING_SYSTEM": "apple-generic"
            ]
        )
        
        if products.contains(.app) {
            let appTarget: Target = .target(
                name: name,
                destinations: .iOS,
                product: .app,
                bundleId: bundleId.isEmpty ? "com.app.\(name.lowercased())" : bundleId,
                deploymentTargets: .iOS("15.0"),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                entitlements: .file(path: .relativeToRoot("Hobbyloop.entitlements")),
                scripts: [],
                dependencies: isExcludedFramework ? dependencies : dependencies + externalDependencies,
                settings: targetSettings
            )
            targets.append(appTarget)
        }
        
        let appScheme: Scheme = .scheme(
            name: name,
            shared: true,
            hidden: false,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(executable: "\(name)")
        )
        
        
        if products.contains(.unitTests) {
          
          var dependencies: [TargetDependency] = [.target(name: name), .xctest]
          dependencies += testDependencies
          
          let target: Target = .target(
            name: "\(name)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.app.\(name.lowercased())Tests",
            infoPlist: .default,
            sources: ["\(name)Tests/**"],
            resources: ["\(name)Tests/**"],
            dependencies: dependencies
          )
          targets.append(target)
        }
        
        if products.contains(.uiTests) {
          let target: Target = .target(
            name: "\(name)UITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.app.\(name.lowercased())UITests",
            sources: "\(name)UITests/**",
            dependencies: [.target(name: name)]
          )
          targets.append(target)
        }
        
        
        if products.filter({ $0.isLibrary}).count != 0 {
            let libraryTarget: Target = .target(
                name: name,
                destinations: .iOS,
                product: products.contains(.library(.static)) ? .staticLibrary : .dynamicLibrary,
                bundleId: "com.app.\(name)",
                deploymentTargets: .iOS("15.0"),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: isExcludedFramework ? dependencies : dependencies + externalDependencies,
                settings: targetSettings
            )
            
            targets.append(libraryTarget)
        }
        
        if products.filter({ $0.isFramework }).count != 0 {
            let frameworkTarget: Target = .target(
                name: name,
                destinations: .iOS,
                product: products.contains(.framework(.static)) ? .staticFramework : .framework,
                bundleId: "com.app.\(name)",
                deploymentTargets: .iOS("15.0"),
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: products.contains(.framework(.dynamic)) ? ["Resources/**"] : nil,
                dependencies: isExcludedFramework ? dependencies : dependencies + externalDependencies,
                settings: targetSettings
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
