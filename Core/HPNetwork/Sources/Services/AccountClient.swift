//
//  AccountClient.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/27.
//

import Foundation

import HPDomain
import HPCommon
import HPExtensions
import Alamofire
import RxSwift

public protocol AccountClientService: AnyObject {
    func requestUserToken(account type: AccountType, accessToken: String) -> Single<Token>
    func requestNaverUserInfo(header type: String, accessToken: String) -> Single<NaverAccount>
    func createUserInfo(birthDay: String, gender: String, name: String, nickname: String, phoneNumber: String) -> Single<UserAccount>
}



public final class AccountClient: BaseNetworkable, AccountClientService {
    
    public static let shared: AccountClient = AccountClient()
    
    public let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = HPAPIEventLogger()
        let authenticator = HPAuthenticator()
        let credential = HPAuthenticationCredential(
            accessToken: LoginManager.shared.readToken(key: .accessToken),
            refreshToken: LoginManager.shared.readToken(key: .refreshToken),
            expiredAt: UserDefaults.standard.date(forKey: .expiredAt) ?? Date()
        )
        let interceptor = AuthenticationInterceptor(
            authenticator: authenticator,
            credential: credential
        )
        
        session = Session(configuration: configuration, interceptor: interceptor, eventMonitors: [eventLogger])
        return session
    }()
    
    private init () {}
    
}


extension AccountClient {
    
    public func requestUserToken(account type: AccountType, accessToken: String) -> Single<Token> {
        
        Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(AccountRouter.getAccessToken(type: type, token: accessToken))
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
    
    
    public func requestNaverUserInfo(header type: String, accessToken: String) -> Single<NaverAccount> {
        Single.create {[weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(AccountRouter.getNaverUserInfo(type: type, accessToken: accessToken))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: NaverAccount.self) { response in
                    switch response.result {
                    case let .success(data):
                        single(.success(data))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }

    }
    
    public func createUserInfo(birthDay: String, gender: String, name: String, nickname: String, phoneNumber: String) -> Single<UserAccount> {
        
        Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(AccountRouter.createUserInfo(birthDay: birthDay, gender: gender, name: name, nickname: nickname, phoneNumber: phoneNumber))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: UserAccount.self) { response in
                    switch response.result {
                    case let.success(data):
                        single(.success(data))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }

    }
}
