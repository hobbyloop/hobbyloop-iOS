//
//  HPRequestInterceptor.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/03.
//

import Foundation


import Alamofire
import HPCommon

public struct HPAuthenticationCredential: AuthenticationCredential {
    public var accessToken: String
    public var refreshToken: String
    public let expiredAt: Date
    public var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5 ) > expiredAt }
}


public final class HPAuthenticator: Authenticator {
    
    public func apply(_ credential: HPAuthenticationCredential, to urlRequest: inout URLRequest) {
        guard !LoginManager.shared.isLogin() else { return }
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        urlRequest.headers.add(name: "refresh-token", value: credential.refreshToken)
    }
    
    public func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {

        return response.statusCode == 401
    }
    
    public func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: HPAuthenticationCredential) -> Bool {
        return urlRequest.headers["Authorization"] == HTTPHeader.authorization(bearerToken: credential.accessToken).value
    }
    
    public func refresh(_ credential: HPAuthenticationCredential, for session: Session, completion: @escaping (Result<HPAuthenticationCredential, Error>) -> Void) {
        
    }
    
    
    
    
    
}


final class HPRequestInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        guard LoginManager.shared.isLogin() else { return }
        
        urlRequest.headers.add(.authorization(bearerToken: LoginManager.shared.readToken(key: .accessToken)))
        urlRequest.headers.add(name: "refresh-token", value: LoginManager.shared.readToken(key: .refreshToken))
        
        completion(.success(urlRequest))
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode,
              !(200..<300).contains(statusCode) else {
            completion(.doNotRetry)
            return
        }
        
        guard statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        completion(.retry)
    }
    
}
