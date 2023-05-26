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

public struct APIClient {
    public static func request<T: Decodable>(_ response: T.Type, _ router: TargetType) -> Single<T> {
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
