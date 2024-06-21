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

public enum AccountRouter {
    case getNaverUserInfo(type: String, accessToken: String)
    case getAccessToken(type: AccountType, token: String)
    case createUserInfo(birthDay: String, gender: String, name: String, nickname: String, phoneNumber: String)
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
            return "/api/v1/profile/create"
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
                "Authorization":"Bearer \(LoginManager.shared.readToken(key: .accessToken))",
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
        case let .createUserInfo(birthDay, gender, name, nickname, phoneNumber):
            return .body([
                "birth": birthDay,
                "gender": gender,
                "name": name,
                "nickname": nickname,
                "phoneNum": phoneNumber
            ])
        }
    }
    
    
}
