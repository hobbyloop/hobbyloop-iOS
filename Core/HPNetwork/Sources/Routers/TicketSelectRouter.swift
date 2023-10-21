//
//  TicketSelectRouter.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/22.
//

import Foundation

import Alamofire
import HPCommon
import HPExtensions


public enum TicketSelectRouter {
    case getFacilityList
    case getUserTicketList
    case getInstructorList(_ id: Int)
}



extension TicketSelectRouter: Router {
    
    
    public var method: HTTPMethod {
        //TODO: 현재 모든 API가 모두 GET이기에 Default get
        return .get
    }
    
    public var path: String {
        switch self {
        case .getFacilityList:
            return "/api/v1/facility/list/all"
        case .getUserTicketList:
            return "/api/v1/ticket/user/list"
        case .getInstructorList:
            return "/api/v1/instructor"
        }
    }
    
    public var parameters: HPParameterType {
        switch self {
        case let .getInstructorList(id):
            return .query(
                [
                "facilityId": id
                ]
            )
        default:
            return .none
        }
    }
    
    public var headers: HTTPHeaders {
        var token: String = ""
        do {
            token = try CryptoUtil.makeDecryption(UserDefaults.standard.string(forKey: .accessToken))
        } catch {
            print(error.localizedDescription)
        }
        return [
            "Authorization": "Bearer \(token)",
            "Accept": "*/*"
         ]
    }
    
    
    
}
