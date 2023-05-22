//
//  TestTarget.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/05/22.
//

import Foundation
import Alamofire

public enum TestTarget {
    case test(TestRequest)
}

extension TestTarget: TargetType {
    public var baseURL: String {
        return "https://www.apiTest.com"
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .test: return .get
        }
    }
    
    public var path: String {
        switch self {
        case .test: return "/test"
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .test(let request): return .body(request)
        }
    }
    
}
