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
        return "https://jsonplaceholder.typicode.com/todos"
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .test: return .get
        }
    }
    
    public var path: String {
        switch self {
        case .test: return "1"
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .test: return .none
        }
    }
    
}
