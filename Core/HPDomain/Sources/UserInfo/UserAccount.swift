//
//  UserAccount.swift
//  HPDomain
//
//  Created by Kim dohyun on 2023/08/21.
//

import Foundation


public struct UserAccount: Decodable {
    
    /// UserAccount Entity의 StatusCode 값
    public let statusCode: Int

    public enum CodingKeys: String, CodingKey {
        case statusCode = "status"
    }
}
