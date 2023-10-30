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
            return "http://13.125.114.152:8080"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .createUserInfo:
            return .post
        default:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getNaverUserInfo:
            return "/v1/nid/me"
        case let .getAccessToken(type, _):
            return "/native/login/oauth2/\(type.rawValue)"
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
            
        case let .getAccessToken(_, accessToken):
            return [
                "Authorization":"\(accessToken)",
                "Accept": "*/*"
            ]
            
        case .createUserInfo:
            return [
                "Authorization":"Bearer \(LoginManager.shared.accessToken)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    public var parameters: HPParameterType {
        
        switch self {
            
        case let .createUserInfo(birthDay, gender, name, nickname, phoneNumber):
            return .body([
                "birth": birthDay,
                "gender": gender,
                "name": name,
                "nickname": nickname,
                "phoneNum": phoneNumber
            ])
        default:
            return .none
        }
    }
    
    
}
