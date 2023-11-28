//
//  BaseNetworkable.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/11/01.
//

import Foundation


import Alamofire

public protocol BaseNetworkable: AnyObject {
    var AFManager: Session { get }
    
}
