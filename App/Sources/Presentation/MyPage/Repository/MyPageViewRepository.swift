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
    var networkService: AccountClientService { get }
    var imageService: ImageClientService { get }
    
    func getMyPageData() -> Observable<MyPageViewReactor.Mutation>
}

public final class MyPageViewRepository: MyPageViewRepo {
    public let networkService: AccountClientService = AccountClient.shared
    public let imageService: ImageClientService = ImageClient.shared
    
    public func getMyPageData() -> Observable<MyPageViewReactor.Mutation> {
        return networkService.getMyPageData()
            .asObservable()
            .catch { error in
                print("mypage error: \(error)")
                return .error(error)
            }
            .flatMap { [weak self] myPageData in
                guard let self else { return Observable<MyPageViewReactor.Mutation>.empty() }
                var imageObservable: Observable<MyPageViewReactor.Mutation> = .empty()
                if let profileImageUrl = myPageData.profileImageUrl {
                    imageObservable = self.imageService.fetchHPImage(url: profileImageUrl)
                        .asObservable()
                        .flatMap { image in
                            return Observable.just(.setProfileImage(image))
                        }
                }
                
                return .merge(.just(.setMyPageData(myPageData)), imageObservable)
            }
    }
}
