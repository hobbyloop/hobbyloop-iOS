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
    case monthlyReservationList(parameter: ReservationParameters)
}


extension ReservationRouter: Router {
    
    public var method: HTTPMethod {
        return .get
    }
    
    
    public var path: String {
        switch self {
        case .getReservationList:
            return "/api/v1/reservation"
        case .monthlyReservationList:
            return "/api/v1/reservation/monthly/list"
        }
    }
    
    public var headers: HTTPHeaders {
        var token: String = ""
        
        do {
            token = try CryptoUtil.makeDecryption(UserDefaults.standard.string(forKey: .accessToken))
        } catch {
            print(error.localizedDescription)
        }
        return [
            "Authorization": "\(token)",
            "Accept": "application/json"
        ]
    }
    
    public var parameters: HPParameterType {
        switch self {
        case let .monthlyReservationList(parameters):
            return .query(parameters)
        default:
            return .none
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