//
//  HPRequestInterceptor.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/03.
//

import Foundation


import Alamofire
import HPCommon


final class HPRequestInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        var accessToken = ""
        do {
           accessToken = try CryptoUtil.makeDecryption(UserDefaults.standard.string(forKey: .accessToken))
        } catch {
            completion(.failure(error))
        }
        
        if accessToken.isEmpty {
            urlRequest.setValue("\(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
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
        
        
        
    }
    
}
