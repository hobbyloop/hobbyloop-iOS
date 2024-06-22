//
//  AccountRouter.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/06/02.
//

import Foundation

import Alamofire
import HPExtensions
import HPCommon

public struct CreatedUserInfo {
    let name: String
    let nickname: String
    let gender: Int
    let birthday: String
    let email: String
    let phoneNumber: String
    let isOption1: Bool
    let isOption2: Bool
    let provider: String
    let subject: String
    let oauth2AccessToken: String
    let ci: String
    let di: String
    
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

public enum AccountRouter {
    case getNaverUserInfo(type: String, accessToken: String)
    case getAccessToken(type: AccountType, token: String)
    case createUserInfo(_ userInfo: CreatedUserInfo)
}



extension AccountRouter: Router {
    
    public var baseURL: String {
        switch self {
        case .getNaverUserInfo:
            return "https://openapi.naver.com"
        default:
            return "https://hobbyloop.kr"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getNaverUserInfo:
            return .get
        case .getAccessToken:
            return .post
        case .createUserInfo:
            return .post
        }
    }
    
    public var path: String {
        switch self {
        case .getNaverUserInfo:
            return "/v1/nid/me"
        case .getAccessToken:
            return "/company-service/api/v1/login/members"
        case .createUserInfo:
            return "/company-service/api/v1/join"
        }
        
    }
    
    public var headers: HTTPHeaders {

        switch self {
        case let .getNaverUserInfo(type, accessToken):
            return [
                "Authorization":"\(type) \(accessToken)",
                "Content-Type": "application/json"
            ]
            
        case .getAccessToken:
            return [
                "Content-Type": "application/json"
            ]
            
        case let .createUserInfo(userInfo):
            return [
                // "Authorization":"Bearer \(userInfo.oauth2AccessToken))",
                "Content-Type": "application/json"
            ]
        }
    }
    
    public var parameters: HPParameterType {
        switch self {
        case .getNaverUserInfo:
            return .none
        case let .getAccessToken(type, token):
            return .body([
                "accessToken": token,
                "provider": type.rawValue.capitalized
            ])
        case let .createUserInfo(userInfo):
            return .body([
                "name": userInfo.name,
                "nickname": userInfo.nickname,
                "gender": userInfo.gender,
                "birthday": userInfo.birthday,
                "email": userInfo.email,
                "phoneNumber": userInfo.phoneNumber,
                "isOption1": userInfo.isOption1,
                "isOption2": userInfo.isOption2,
                "provider": userInfo.provider,
                "subject": userInfo.subject,
                "oauth2AccessToken": userInfo.oauth2AccessToken,
                "ci": userInfo.ci,
                "di": userInfo.di
            ])
        }
    }
    
    
}
