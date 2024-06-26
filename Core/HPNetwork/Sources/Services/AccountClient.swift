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
import FirebaseAuth
import FirebaseMessaging

public protocol AccountClientService: AnyObject {
    func requestUserToken(account type: AccountType, accessToken: String) -> Single<LoginResponseBody>
    func requestNaverUserInfo(header type: String, accessToken: String) -> Single<NaverAccount>
    func createUserInfo(_ userInfo: JoinRequestBody) -> Single<JoinResponseBody>
    func issueVerificationID(phoneNumber: String) -> Single<String>
    func verifyPhoneNumber(authCode: String, verificationID: String) -> Single<Void>
}



public final class AccountClient: BaseNetworkable, AccountClientService {
    
    public static let shared: AccountClient = AccountClient()
    
    public let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = HPAPIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        return session
    }()
    
    private init () {}
    
}


extension AccountClient {
    
    public func requestUserToken(account type: AccountType, accessToken: String) -> Single<LoginResponseBody> {
        return Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(AccountRouter.getAccessToken(type: type, token: accessToken))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: LoginResponseBody.self) { response in
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
        return Single.create {[weak self] single -> Disposable in
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
    
    public func createUserInfo(_ userInfo: JoinRequestBody) -> Single<JoinResponseBody> {
        return Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(AccountRouter.createUserInfo(userInfo))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: JoinResponseBody.self) { response in
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
    
    public func issueVerificationID(phoneNumber: String) -> Single<String> {
        return Single.create { single in
            PhoneAuthProvider.provider()
                .verifyPhoneNumber("+82 \(phoneNumber)", uiDelegate: nil) { verificationID, error in
                    if let error {
                        single(.failure(error))
                        print("issue error: \(error)")
                    }
                    
                    if let verificationID {
                        single(.success(verificationID))
                    }
                }
            
            return Disposables.create()
        }
    }
    
    public func verifyPhoneNumber(authCode: String, verificationID: String) -> Single<Void> {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: authCode
        )
        
        return Single.create { single in
            Auth.auth().signIn(with: credential) { authData, error in
                if let error {
                    single(.failure(error))
                    return
                }
                
                single(.success(()))
            }
            
            return Disposables.create()
        }
    }
}
