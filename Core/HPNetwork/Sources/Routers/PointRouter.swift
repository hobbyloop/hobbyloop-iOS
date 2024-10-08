//
//  PointRouter.swift
//  HPNetwork
//
//  Created by 김남건 on 6/28/24.
//

import Foundation
import Alamofire

public enum PointRouter: Router {
    case getPointHistory
    case getExpiredPoint
    
    public var baseURL: String {
        return "https://hobbyloop.kr"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getPointHistory:
            return .get
        case .getExpiredPoint:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getPointHistory:
            return "ticket-service/api/v1/points/histories"
        case .getExpiredPoint:
            return "ticket-service/api/v1/points/histories/expiring-soon"
        }
    }
    
    public var headers: HTTPHeaders {
        switch self {
        case .getPointHistory:
            return [
                "Content-Type": "application/json"
            ]
        case .getExpiredPoint:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    public var parameters: HPParameterType {
        switch self {
        case .getPointHistory:
            return .none
        case .getExpiredPoint:
            return .none
        }
    }
}
