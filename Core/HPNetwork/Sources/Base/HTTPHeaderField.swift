//
//  HTTPHeaderField.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/05/22.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "Application/json"
}
