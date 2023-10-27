//
//  AccountClient.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/27.
//

import Foundation

import HPDomain
import HPCommon
import Alamofire
import RxSwift

public protocol AccountClientService: AnyObject {
    func requestUserToken(account type: AccountType, accessToken: String) -> Single<Token>
    
}



public final class AccountClient: AccountClientService {
    
    public static let shared: AccountClient = AccountClient()
    
    private init () {}
    
}


extension AccountClient {
    
    public func requestUserToken(account type: AccountType, accessToken: String) -> Single<Token> {
        
        return Single.create { single -> Disposable in
            AF.request(AccountRouter.getAccessToken(type: type, token: accessToken))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: Token.self) { response in
                    switch response.result {
                    case let .success(data):
                        single(.success(data))
                    case let .failure(error):
                        print(error.localizedDescription)
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
    
}
