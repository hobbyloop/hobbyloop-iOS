//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/03/21.
//

import ProjectDescription

extension InfoPlist {
    
    static func configure(name: String, bundleId: String = "") -> [String: InfoPlist.Value] {
        
        return [
            "NMFClientId" : .string("0q2nxzajdq"),
            "CFBundleName" : .string(name),
            "CFBundleDisplayName" : .string(name),
            "CFBundleIdentifier" : .string("com.sideproj.\(name)"),
            "CFBundleShortVersionString" : .string("1.0"),
            "CFBundleVersion" : .string("0"),
            "CFBuildVersion" : .string("0"),
            "UILaunchStoryboardName" : .string("Launch Screen"),
            "UISupportedInterfaceOrientations" : .array([.string("UIInterfaceOrientationPortrait")]),
            "UIUserInterfaceStyle" : .string("Light"),
            "LSApplicationQueriesSchemes": .array(
                [.string("kakaokompassauth"), .string("naversearchapp") ,.string("naversearchthirdlogin")]
            ),
            "CFBundleURLTypes": .array([
                .dictionary([
                    "CFBundleURLSchemes": .array(["hobbyloop"]),
                    "CFBundleURLName": .string("hobbyloop")
                ]),
                .dictionary([
                    "CFBundleURLSchemes": .array(["kakaoe8e2221cc437bed1a098ce95fee11f1d"])
                ]),
                .dictionary([
                    "CFBundleTypeRole": .string("Editor"),
                    "CFBundleURLSchemes": .array([.string("com.googleusercontent.apps.565615287672-emohfjcbdultg158jdvjrbkuqsgbps8a")])
                ])
            ]),
            "UIApplicationSceneManifest" : .dictionary([
                "UIApplicationSupportsMultipleScenes" : .boolean(false),
                "UISceneConfigurations" : .dictionary([
                    "UIWindowSceneSessionRoleApplication" : .array([
                        .dictionary([
                            "UISceneConfigurationName" : .string("Default Configuration"),
                            "UISceneDelegateClassName" : .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                        ])
                    ])
                ])
            ])
        ]
    }
    
    public static func base(name: String) -> Self {
        return .extendingDefault(with: InfoPlist.configure(name: name))
    }
    
}



