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
import HPDomain

public enum AccountRouter {
    case getNaverUserInfo(type: String, accessToken: String)
    case getAccessToken(type: AccountType, token: String)
    case createUserInfo(_ userInfo: CreatedUserInfo)
    case getMyPageData
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
        case .getMyPageData:
            return .get
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
        case .getMyPageData:
            return "/company-service/api/v1/members/my-page"
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
            
        case .createUserInfo:
            return [
                "Content-Type": "application/json"
            ]
        case .getMyPageData:
            return [
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
        case .getMyPageData:
            return .none
        }
    }
    
    
}
