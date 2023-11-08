//
//  TicketSelectClient.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/22.
//

import Foundation

import HPCommon
import HPExtensions
import HPDomain
import Alamofire
import RxSwift



/**
  TicketSelectClient 에게 행위(Behavier)를 정의하기 위한 interface
 
 */
public protocol TicketSelectService: AnyObject {
    func requestToInstructorList(id: Int) -> Single<Instructor>
    func requestToTicketInfoList() -> Single<TicketInfo>
        
}


public final class TicketSelectClient: BaseNetworkable, TicketSelectService {
    public let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = HPAPIEventLogger()
        let authenticator = HPAuthenticator()
        let interceptor = HPRequestInterceptor()
        
        session = Session(
            configuration: configuration,
            interceptor: interceptor,
            eventMonitors: [eventLogger]
        )
        return session

    }()
    
    
    public static let shared: TicketSelectClient = TicketSelectClient()
    
    private init () {}
}


extension TicketSelectClient {
    
    public func requestToInstructorList(id: Int) -> Single<Instructor> {
        
        return Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(TicketSelectRouter.getInstructorList(id))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: Instructor.self) { response in
                    //MARK: Token 관련 로직 Single Tone Pattern 수정 후 사용
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
    
    
    public func requestToTicketInfoList() -> Single<TicketInfo> {
        return Single.create { [weak self] single -> Disposable in
            guard let self = `self` else { return Disposables.create() }
            self.AFManager.request(TicketSelectRouter.getUserTicketList)
                .responseDecodable(of: TicketInfo.self) { response in
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

