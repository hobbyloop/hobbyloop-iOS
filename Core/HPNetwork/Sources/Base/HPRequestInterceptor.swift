//
//  HPRequestInterceptor.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/03.
//

import Foundation


import Alamofire
import HPCommon

public final class HPRequestInterceptor: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        guard urlRequest.url?.absoluteString.hasPrefix("http://13.125.114.152:8080") == true else {
            completion(.success(urlRequest))
            return
        }
        
        urlRequest.headers.add(.authorization(bearerToken: LoginManager.shared.readToken(key: .accessToken)))
        urlRequest.headers.add(name: "Authorization-refresh", value: "Bearer \(LoginManager.shared.readToken(key: .refreshToken))")
        
        completion(.success(urlRequest))
    }
        
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let accessToken = request.response?.headers.value(for: "Authorization") else { return }
        LoginManager.shared.updateAccessToken(accessToken: accessToken)
        completion(.retry)
        
        guard let statusCode = request.response?.statusCode, statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
    }
    
}
