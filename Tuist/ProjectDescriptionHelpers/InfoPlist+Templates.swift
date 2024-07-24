//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/03/21.
//

import ProjectDescription

extension InfoPlist {
    
    static func configure(name: String, bundleId: String = "") -> [String: Plist.Value] {
        
        return [
            "ITSAppUsesNonExemptEncryption": .boolean(false),
            "NSLocationWhenInUseUsageDescription" : .string("위치가 필요하다"),
            "NSLocationAlwaysAndWhenInUseUsageDescription" : .string("위치가 필요하다"),
            "NSPhotoLibraryAddUsageDescription": .string("하비루프(이)가 사용자의 사진에 접근하려고 합니다."),
            "NMFClientId" : .string("0q2nxzajdq"),
            "CFBundleName" : .string(name),
            "CFBundleIconName": .string("AppIcon"),
            "CFBundleDisplayName" : .string(name),
            "CFBundleIdentifier" : .string("com.app.\(name.lowercased())"),
            "CFBundleShortVersionString" : .string("1.0"),
            "CFBundleVersion" : .string("1"),
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
                    "CFBundleURLSchemes": .array(["kakao952e63b33ea5dd5fc5fbd0cf7b388dbb"])
                ]),
                .dictionary([
                    "CFBundleTypeRole": .string("Editor"),
                    "CFBundleURLSchemes": .array([.string("com.googleusercontent.apps.895737876071-015c8r6g3mpv65hoe89elahead2snj9n")])
                ]),
                .dictionary([
                    "CFBundleURLSchemes": .array(["app-1-557614392787-ios-bf6c62aeac2a1181e6bb26"])
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



