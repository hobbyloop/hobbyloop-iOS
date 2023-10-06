//
//  ReservationRouter.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/10/06.
//

import Foundation

import Alamofire
import HPCommon
import RxSwift
import HPDomain


public enum ReservationRouter {
    case getReservationList
}


extension ReservationRouter: Router {
    
    public var method: HTTPMethod {
        return .get
    }
    
    
    public var path: String {
        return "/api/v1/reservation"
    }
    
    public var headers: HTTPHeaders {
        switch self {
        case .getReservationList:
            return [
                "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwMzA2MzE5NiwidXNlcm5hbWUiOiJLQUtBT18yNzU2NzQ4NjkwIn0.atgaUMY1DD-jlzlRudeiaf0m12D8N-tKmDB-_TiaTZUwL6aVVfXcq43rgl_2djG66PPrmct0fSs8l4ANhw1pGg",
                "Accept": "*/*"
            ]
        }
    }
    
}



//TODO: Merge 후 로직 분리
public protocol ReservationService: AnyObject {
    func requestToReservationList() -> Single<LatestReservation>
}



public final class ReservationClient: ReservationService {
    public static let shared: ReservationClient = ReservationClient()
    
    private init() {}
    
    
    
}


extension ReservationClient {
    

    public func requestToReservationList() -> Single<LatestReservation> {
        return Single.create { single -> Disposable in
            AF.request(ReservationRouter.getReservationList)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: LatestReservation.self) { response in
                    switch response.result {
                    case let .success(data):
                        single(.success(data))
                    case let .failure(error):
                        print("\(error.localizedDescription)")
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
}
