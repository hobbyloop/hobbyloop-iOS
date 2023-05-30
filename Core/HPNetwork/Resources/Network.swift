//
//  Network.swift
//  HPNetwork
//
//  Created by 김진우 on 2023/04/10.
//

import Foundation

import Alamofire

/// 에러 정의
enum NetworkError: Error {
    case notValidateStatusCode  // 유효하지 않는 StatusCode
    case noData                 // 결과 데이터 미존재
    case failDecode             // Decode 실패
}

/// 통신 Enum
enum Network {
    // 통신 케이스 작성
    case test
}

// MARK: 통신 필요 정보 관련
extension Network {
    /// API Key
    private var key: String {"API 키"}
    
    /// 도메인
    private var domain: String {
        switch self {
        case .test:
            return "https://test.com"
        }
    }
    
    /// URL Path
    private var path: String {
        switch self {
        case .test:
            return "/test"
        }
    }
    
    /// HTTP 메소드
    private var method: Alamofire.HTTPMethod {
        switch self {
        case .test:
            return .get
        }
    }
    
    /// API Key 필요 여부
    private var isNeedAPIKey: Bool {
        switch self {
        case .test:
            return true
        default:
            return false
        }
    }
    
    /// 통신 헤더
    private var header: HTTPHeaders {
        
        var result = HTTPHeaders([
            HTTPHeader(name:"Content-Type", value: "application/json"),
            HTTPHeader(name:"Accept", value: "application/json; charset=UTF-8"),
        ])
        
        if isNeedAPIKey {
            result.add(HTTPHeader(name: "test", value: key))
        }
        return result
    }
    
    /// Body Parameter - 주로 Get으로 예상되어 필요 x
    private var parameter: [String:Any]? {
        switch self {
        case .test:
            return nil
        }
    }
}

extension Network {
    /// 통신 요청 (with Generic)
    /// - Parameters:
    ///     - dataType: Generic으로 선언된 자료형의 타입을 받는다.
    ///     - complete: 클로저 - 성공시 T의 객체, 실패시 선언해둔 에러
    func request<T: Decodable>(dataType: T.Type, complete: @escaping ((Result<T?, NetworkError>) -> ())) {
        var url = domain
        if let convertedPath = path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            url += convertedPath
        }
        AF.request(
            url,
            method: method,
            parameters: parameter,
            headers: header
        )
        .responseDecodable(of: T.self) { response in
            
            // 통신 결과 처리
            switch response.result {
            case .success(let dict):
                // 성공
                if response.data == nil {
                    complete(.failure(.noData))
                    return
                }
                
                complete(.success(dict))
            case .failure(let error):
                // 결과는 없지만 statusCode 확인 필요
                if let stCode = response.response?.statusCode, 200..<300 ~= stCode {
                    // 성공
                    complete(.success(nil))
                } else if error.isParameterEncodingError {
                    // 디코딩 실패
                    complete(.failure(.failDecode))
                } else {
                    // 통신 실패
                    complete(.failure(.notValidateStatusCode))
                }
            }
        }
    }
    
}
