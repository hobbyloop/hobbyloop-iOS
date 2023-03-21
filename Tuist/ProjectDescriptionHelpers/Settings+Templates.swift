//
//  Settings+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 2023/03/21.
//

import ProjectDescription

extension Settings {
    
    public static var `default`: Self {
        
        let baseSettings: [String: SettingValue] = [:]
        
        return .settings(
            base: baseSettings,
            configurations: [
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )
    }
    
}
