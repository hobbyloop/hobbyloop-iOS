//
//  APIClient.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

import HPExtensions

import Alamofire
import RxSwift


/// APIClinet 객체를 Dependency Inversion Principle를 통해 Protocol을 의존하기 위한 interface
/// - note: APIClient Object의 의존하지 않고 Protocol에 의존하도록 구현하기 위한 interface
public protocol APIService {
    func request<T: Decodable>(_ response: T.Type, _ router: Router) -> Single<T>
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
}
