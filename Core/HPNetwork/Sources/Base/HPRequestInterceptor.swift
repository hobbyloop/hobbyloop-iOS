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
        print("✅HPAUTHENTICATOR METHOD CALL✅")
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        urlRequest.headers.add(name: "Authorization-refresh", value: credential.refreshToken)
    }
    
    public func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        print("⛔️HPAUTHENTICATOR DIDREQUEST METHOD CALL⛔️")
        return response.statusCode == 401
    }
    
    public func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: HPAuthenticationCredential) -> Bool {
        print("⛔️HPAUTHENTICATOR ISREQUEST METHOD CALL⛔️")
        return urlRequest.headers["Authorization"] == HTTPHeader.authorization(bearerToken: credential.accessToken).value
    }
    
    public func refresh(_ credential: HPAuthenticationCredential, for session: Session, completion: @escaping (Result<HPAuthenticationCredential, Error>) -> Void) {
        
        print("⛔️HPAUTHENTICATOR REFRESH METHOD CALL⛔️")
        print("📌USER CREDENTIAL EXPIREDAT: \(credential.expiredAt)📌")
        print("🚀USER REQUIRES REFRESH \(credential.requiresRefresh)🚀")
    }
    
    
    
    
    
}


public final class HPRequestInterceptor: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        guard urlRequest.url?.absoluteString.hasPrefix("http://13.125.114.152:8080") == true else {
            completion(.success(urlRequest))
            return
        }
        
        print("😍 HPREQUSET INTERCEPTOR ADAPT METHOD CALL 😍")
        urlRequest.headers.add(.authorization(bearerToken: LoginManager.shared.readToken(key: .accessToken)))
        urlRequest.headers.add(name: "Authorization-refresh", value: "Bearer \(LoginManager.shared.readToken(key: .refreshToken))")
        
        completion(.success(urlRequest))
    }
        
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode,
              !(200..<300).contains(statusCode) else {
            completion(.doNotRetry)
            return
        }
        
        let refreshToken = request.response?.headers.value(for: "Authorization-refresh")
        print("😆 HPREQUEST INTERCEPTOR RETRY METHOD CALL \(statusCode)😆")
        print("🔐 HPREQUEST INTERCEPTOR RETRY METHOD CALL \(refreshToken)🔐")
        guard statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        completion(.retry)
    }
    
}
