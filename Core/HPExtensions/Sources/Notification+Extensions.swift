//
//  Notification+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/09/25.
//

import Foundation


public extension Notification.Name {
    
    static let popToViewController = Notification.Name("popToViewController")
    static let searchToViewController = Notification.Name("searchToViewController")
    static let notiToViewController = Notification.Name("notiToViewController")
    
    
    static let moreAction = Notification.Name("moreAction")
    static let bookMarkAction = Notification.Name("bookMarkAction")
    static let settingAction = Notification.Name("settingAction")
    
}
