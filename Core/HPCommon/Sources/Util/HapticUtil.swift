//
//  HapticUtil.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/08.
//

import UIKit


public enum HapticUtil {
    ///  - note: 유저 인터페이스와 개체와 충돌할때
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    ///  - note: Alert 창과 같을 실패 유무 등을 알릴때
    case notification(UINotificationFeedbackGenerator.FeedbackType)
    ///  - note: 유저가 특정 UI를 선택 할때
    case selection
    
    
    public func generate() {
        switch self {
        case let .impact(feedbackStyle):
            let generator = UIImpactFeedbackGenerator(style: feedbackStyle)
            generator.prepare()
            generator.impactOccurred()
        case let .notification(feedbackType):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(feedbackType)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
}
