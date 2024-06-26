//
//  CreatedUserInfo.swift
//  HPDomain
//
//  Created by 김남건 on 6/26/24.
//

import Foundation

/// 회원가입 화면에서 사용되는 사용자 정보들을 담은 모델
public struct CreatedUserInfo {
    public let name: String
    public let nickname: String
    public let gender: Int
    public let birthday: String
    public let email: String
    public let phoneNumber: String
    public let isOption1: Bool
    public let isOption2: Bool
    public let provider: String
    public let subject: String
    public let oauth2AccessToken: String
    public let ci: String
    public let di: String
    
    public init(name: String, nickname: String, gender: Int, birthday: String, email: String, phoneNumber: String, isOption1: Bool, isOption2: Bool, provider: String, subject: String, oauth2AccessToken: String, ci: String, di: String) {
        self.name = name
        self.nickname = nickname
        self.gender = gender
        self.birthday = birthday
        self.email = email
        self.phoneNumber = phoneNumber
        self.isOption1 = isOption1
        self.isOption2 = isOption2
        self.provider = provider
        self.subject = subject
        self.oauth2AccessToken = oauth2AccessToken
        self.ci = ci
        self.di = di
    }
}
