//
//  APIClient.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

import HPExtensions
import HPCommon
import Alamofire
import RxSwift


/// APIClinet 객체를 Dependency Inversion Principle를 통해 Protocol을 의존하기 위한 interface
/// - note: APIClient Object의 의존하지 않고 Protocol에 의존하도록 구현하기 위한 interface
public protocol APIService {
    func request<T: Decodable>(_ response: T.Type, _ router: Router) -> Single<T>
    func requestToAuthentication(_ router: Router, completion: @escaping () -> Void)
}


public final class APIClient: APIService {
    
    public static let shared: APIClient = APIClient()
    
    private init() {}
    
    public func request<T: Decodable>(_ response: T.Type, _ router: Router) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            AF.request(router)
                .responseDecodable(of: response) { response in
                    switch response.result {
                    case .success(let data):
                        LogFile.logging("Network Success: \(data)")
                        single(.success(data))
                    case .failure(let error):
                        LogFile.logging("Network Error: \(error)")
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
    
    /// 소셜 로그인 AccessToken Response 하기 위한 메서드
    /// - note: 사용자가 소셜 로그인후 받은 Access Token 값을 자체 서버 에게 전달 하기 위한 메서드
    /// - parameters:
    ///   - Router 서버 요청시 필요한 공통 인터페이스 객체
    ///   - completion JWT 발급 후 호출해야할 메서드(정해진 메서드 없음)
    public func requestToAuthentication(_ router: Router, completion: @escaping () -> Void) {
        AF.request(router)
            .responseString(emptyResponseCodes: [200, 204, 205],completionHandler: { response in
                switch response.result {
                case .success(_):
                    do {
                        if let responseHeader = response.response?.value(forHTTPHeaderField: "Authorization") {
                            let chiperToken = try CryptoUtil.makeEncryption(responseHeader)
                            UserDefaults.standard.set(chiperToken, forKey: .accessToken)
                        }
                        completion()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                case let .failure(error):
                    LogFile.logging("Network Auth Error: \(error)")
                }
            })
    }
}
