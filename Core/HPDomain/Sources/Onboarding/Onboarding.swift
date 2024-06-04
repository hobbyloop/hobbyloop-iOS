//
//  Onboarding.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/06/28.
//

import Foundation

public struct Onboarding {
    
    /// 온보딩 소개글
    public let title: [String] = [
        "하단 이용권 창을 클릭 한 후\n원하는 시설을 선택 해주세요!",
        "선택한 시설이 마음에 드셨다면",
        "이용권·수업 정보로 이동해\n 원하시는 이용권을 구매할 수 있어요!",
        "구매한 이용권으로 해당시설의\n다양한 수업을 예약 해보세요!"
    ]
    
    /// 온보딩 이미지
    public let image: [String] = [
        "onboarding_first",
        "onboarding_second",
        "onboarding_third",
        "onboarding_fourth"
    ]
        
    public init() {}
    
    
    
}
