//
//  PointViewRepository.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/28/24.
//

import Foundation
import RxSwift
import HPNetwork

public protocol PointViewRepo {
    var networkService: PointClientService { get }
    
    func getPointHisotryData() -> Observable<PointViewReactor.Mutation>
    func getExpiredPointInfo() -> Observable<PointViewReactor.Mutation>
}

public final class PointViewRepository: PointViewRepo {
    public var networkService: PointClientService = PointClient.shared
    
    public func getPointHisotryData() -> Observable<PointViewReactor.Mutation> {
        networkService.getPointHistory()
            .asObservable()
            .catch { error in
                // TODO: 에러 핸들링
                return .empty()
            }
            .map { historyData in
                return .setPointHistoryData(historyData)
            }
    }
    
    public func getExpiredPointInfo() -> Observable<PointViewReactor.Mutation> {
        networkService.getExpriedPointInfo()
            .asObservable()
            .catch { error in
                // TODO: 에러 핸들링
                return .empty()
            }
            .map { expiredPointInfo in
                return .setExpriedPointInfo(expiredPointInfo)
            }
    }
}
