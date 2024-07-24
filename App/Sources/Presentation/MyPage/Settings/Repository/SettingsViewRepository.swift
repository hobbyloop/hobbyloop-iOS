//
//  SettingsViewRepository.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/30/24.
//

import Foundation
import HPNetwork
import RxSwift

public protocol SettingsViewRepo {
    var disposeBag: DisposeBag { get }
    var networkService: AccountClientService { get }
    
    func quitAccount() -> Observable<SettingsViewReactor.Mutation>
}

public final class SettingsViewRepository: SettingsViewRepo {
    public var disposeBag = DisposeBag()
    public var networkService: AccountClientService = AccountClient.shared
    
    public func quitAccount() -> Observable<SettingsViewReactor.Mutation> {
        self.networkService.quitAccount()
            .asObservable()
            .catch { _ in
                return .empty()
            }
            .map {
                return .quit
            }
    }
}
