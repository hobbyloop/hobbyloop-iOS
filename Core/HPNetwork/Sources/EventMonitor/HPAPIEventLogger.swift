//
//  HPAPIEventLogger.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/11/01.
//

import Foundation

import HPExtensions
import Alamofire


public final class HPAPIEventLogger: EventMonitor {
    
    public let queue: DispatchQueue = DispatchQueue(label: "HPAPIEventLogger")
    
    public func requestDidResume(_ request: Request) {
        print("🚀 HPAPI NETWORK REQUEST LOG 🚀")
        print(request.description)
        
        
        print("🌎 URL: " + (request.request?.url?.absoluteString ?? "") + "\n" + "🎮 METHOD:" + (request.request?.httpMethod ?? "") + "\n" + "📝 HEADERS: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n" )
        
        print("💁‍♂️ AUTHORIZATION: " + (request.request?.headers["Authorization"] ?? ""))
        print("🗣️ BODY: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("🚀 HPAPI NETWORK RESPONSE LOG 🚀")
        print(request.description)
        
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 200..<300:
                print("✅ HPAPI NETWORK RESPONSE SUCCESS ✅")
                print("🧾 RESPONSE DATA: " + "\n" + "\(response.data?.toPrettyPrintedString ?? "")")
            case 400..<500:
                print("⛔️ HPAPI NETWORK RESPONSE FAILURE⛔️")
                print("❗오류 발생 : RequestError\n" + "잘못된 요청입니다. request를 재작성 해주세요.")
            default:
                break
            }
        }
    }
    

    
    public func requestDidCancel(_ request: Request) {
        print("⛔️ HPAPI NETWORK CANCEL LOG ⛔️")
        print("😭 URL: " + (request.request?.url?.absoluteString ?? "") + "\n" + "🤔 METHOD:" + (request.request?.httpMethod ?? "") + "\n" + "🙋‍♂️ HEADERS: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n")
        print("🥸 AUTHORIZATION: " + (request.request?.headers["Authorization"] ?? ""))
        
    }

}
