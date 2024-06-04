//
//  AccountType.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/03.
//

import Foundation

@frozen
public enum AccountType: String, Equatable {
    case kakao
    case naver
    case google
    case apple
    case none
}
