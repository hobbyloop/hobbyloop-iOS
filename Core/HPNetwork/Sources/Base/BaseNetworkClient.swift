//
//  BaseNetworkClient.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/11/01.
//

import Foundation

import Alamofire


public class BaseNetworkClient {
    let AFManager: Session = {
            var session = AF
            let configuration = URLSessionConfiguration.af.default
            let eventLogger = HPAPIEventLogger()
            session = Session(configuration: configuration, eventMonitors: [eventLogger])
            return session
    }()
    
    public init () {}
    
}
