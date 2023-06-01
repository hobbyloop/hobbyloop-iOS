//
//  Router.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/06/01.
//

import Foundation

import Alamofire


public protocol Router: URLRequestConvertible {
    
    /// 공용 base URL
    var baseURL: String { get }
    
    /// HTTP Request Method
    var method: HTTPMethod { get }
    
    /// HTTP Request Path
    var path: String { get }
    
    /// HTTP Request Parameter
    var parameters: HPParameterType { get }
    
    /// HTTP 공용 헤더 값
    var headers: HTTPHeaders { get }
}



extension Router {
    
    public var baseURL: String {
        return "http://13.125.114.152:8080"
    }
    
    public var parameters: HPParameterType {
        return .none
    }
    
    public var headers: HTTPHeaders {
        return .default
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        switch parameters {
        case .query(let data):
            let params = data?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let data):
            let params = data?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .none:
            break
        }

        return urlRequest
    }
    
    
}

