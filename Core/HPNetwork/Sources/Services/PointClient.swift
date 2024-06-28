//
//  PointClient.swift
//  HPNetwork
//
//  Created by 김남건 on 6/28/24.
//

import Foundation
import HPDomain
import RxSwift
import Alamofire

public protocol PointClientService: AnyObject {
    func getPointHistory() -> Single<PointHistoryData>
}

public final class PointClient: BaseNetworkable, PointClientService {
    public static let shared = PointClient()
    
    public var AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = HPAPIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        return session
    }()
    
    private init() {}
    
    public func getPointHistory() -> Single<PointHistoryData> {
        return Single.create { [weak self] single in
            guard let self else { return Disposables.create() }
            
            self.AFManager.request(PointRouter.getPointHistory, interceptor: HPRequestInterceptor())
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PointHistoryResponseBody.self) { response in
                    switch response.result {
                    case let.success(responseBody):
                        single(.success(responseBody.data))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
