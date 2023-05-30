//
//  TestRequest.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/05/22.
//

import Foundation

public struct TestRequest: Encodable {
    let testName: String
    let password: String
    
    public init(testName: String, password: String) {
        self.testName = testName
        self.password = password
    }
}
