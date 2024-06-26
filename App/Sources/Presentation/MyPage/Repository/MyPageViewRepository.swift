//
//  MyPageViewRepository.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/26/24.
//

import Foundation
import HPDomain
import RxSwift
import HPNetwork

public protocol MyPageViewRepo {
    func getMyPageData() -> Observable<MyPageViewReactor.Mutation>
}

public final class MyPageViewRepository: MyPageViewRepo {
    public var networkService: AccountClientService = AccountClient.shared
    
    public func getMyPageData() -> Observable<MyPageViewReactor.Mutation> {
        return networkService.getUserInfo()
            .asObservable()
            .catch { error in
                // TODO: 에러 핸들링
                return .empty()
            }
            .map { myPageData in
                return .setMyPageData(myPageData)
            }
    }
}
