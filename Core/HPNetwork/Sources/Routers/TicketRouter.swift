//
//  TicketRouter.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/10/12.
//

import Foundation

import Alamofire
import HPCommon



public enum TicketRouter {
    case getFacilityList(token: String, facilitySortType: FacilitySortType, ticketType: TicketType, mapx: Double, mapy: Double, page: Int)
    case FacilityArchive(token: String, facilityId: Int)
    
}

/// 시설/이용권 정보 라우터
extension TicketRouter: Router {
    
    public var baseURL: String {
        return "http://13.125.114.152:8080"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getFacilityList:
            return .get
        case .FacilityArchive(_, _):
            return .post
        }
    }
    
    public var path: String {
        switch self {
            
        case .getFacilityList(_, _, _, _, _, _):
            return "/api/v1/facility/list/ranking"
        case .FacilityArchive(_, _):
            return "/api/v1/bookmark"
        }
    }
    
    public var parameters: HPParameterType {
        switch self {
        case .getFacilityList(_, let facilitySortType, let ticketType, let mapx, let mapy, let page):
            return .query([
                "facilitySortType": facilitySortType.description,
                "ticketType": ticketType.rawValue,
                "mapx": String(mapx),
                "mapy": String(mapy),
                "page": String(page),
                "size": "10"
            ])
        case .FacilityArchive(_, let facilityId):
            return .query([
                "facilityId": facilityId
            ])
        }
    }
    
    public var headers: HTTPHeaders {
        switch self {
        case let .getFacilityList(token, _, _, _, _, _):
            return [
                "Authorization": "Bearer \(token)",
                "Accept": "*/*"
            ]
        case .FacilityArchive(let token, _):
            return [
                "Authorization": "Bearer \(token)",
                "Accept": "*/*"
            ]
        }
    }
    
    
    
    
    
}
