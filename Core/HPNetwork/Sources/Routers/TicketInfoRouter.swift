//
//  TicketInfoRouter.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/08/20.
//

import Foundation

import Alamofire
import HPCommon



public enum TicketInfoRouter {
    case getUserTicketList(token: String)
    
}



/// 사용자 티켓 정보 라우터
extension TicketInfoRouter: Router {
    
    public var baseURL: String {
        return "http://13.125.114.152:8080"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getUserTicketList:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getUserTicketList:
            return "/api/v1/ticket/user/list"
        }
    }
    
    public var headers: HTTPHeaders {
        switch self {
        case let .getUserTicketList(token):
            return [
                "Authorization": "\(token)",
                "Accept": "*/*"
            ]
        }
    }
    
    
    
    
    
}
