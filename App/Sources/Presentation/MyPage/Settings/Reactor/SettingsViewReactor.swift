//
//  SettingsViewReactor.swift
//  Hobbyloop
//
//  Created by 김남건 on 6/27/24.
//

import Foundation
import ReactorKit
import RxSwift
import HPNetwork

public final class SettingsViewReactor: Reactor {
    private var settingsRepository: SettingsViewRepo
    public var initialState: State = State(
        isLoading: false,
        receivesAppAlarm: UserDefaults.standard.bool(forKey: .receivesAppAlarm),
        receivesAdAlarm: UserDefaults.standard.bool(forKey: .receivesAdAlarm),
        logout: (),
        quit: ()
    )
    
    public enum Action {
        case didToggleAppAlarmSwitch
        case didToggleAdAlarmSwitch
        case didTapLogoutButton
        case didTapQuitButton
    }
    
    public enum Mutation {
        case setLoading(Bool)
        case setReceivesAppAlarm(Bool)
        case setReceivesAdAlarm(Bool)
        case logout
        case quit
    }
    
    public struct State {
        var isLoading: Bool
        var receivesAppAlarm: Bool
        var receivesAdAlarm: Bool
        @Pulse var logout: Void
        @Pulse var quit: Void
    }
    
    init(settingsRepository: SettingsViewRepo) {
        self.settingsRepository = settingsRepository
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didToggleAppAlarmSwitch:
            return .just(.setReceivesAppAlarm(!currentState.receivesAppAlarm))
        case .didToggleAdAlarmSwitch:
            return .just(.setReceivesAdAlarm(!currentState.receivesAdAlarm))
        case .didTapLogoutButton:
            return .just(.logout)
        case .didTapQuitButton:
            return .concat([
                .just(.setLoading(true)),
                settingsRepository.quitAccount(),
                .just(.setLoading(false))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setReceivesAppAlarm(let receivesAppAlarm):
            newState.receivesAppAlarm = receivesAppAlarm
            UserDefaults.standard.set(receivesAppAlarm, forKey: .receivesAppAlarm)
        case .setReceivesAdAlarm(let receivesAdAlarm):
            newState.receivesAdAlarm = receivesAdAlarm
            UserDefaults.standard.set(receivesAdAlarm, forKey: .receivesAdAlarm)
        case .logout:
            LoginManager.shared.removeAll()
            newState.logout = ()
        case .quit:
            newState.quit = ()
        }
        
        return newState
        
    }
}
