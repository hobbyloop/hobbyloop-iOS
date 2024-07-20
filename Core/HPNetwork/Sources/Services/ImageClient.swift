//
//  ImageClient.swift
//  HPNetwork
//
//  Created by 김남건 on 7/18/24.
//

import Foundation
import UIKit
import Alamofire
import RxSwift

public protocol ImageClientService: AnyObject {
    func fetchHPImage(url: URL) -> Single<UIImage>
}

public final class ImageClient: BaseNetworkable, ImageClientService {
    public static let shared: ImageClient = ImageClient()
    
    public let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = HPAPIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        return session
    }()
    
    private init () {}
    
    public func fetchHPImage(url: URL) -> Single<UIImage> {
        Single.create { [weak self] single in
            guard let self else { return Disposables.create() }
            self.AFManager.request(url.absoluteString, interceptor: HPRequestInterceptor()).response { response in
                switch response.result {
                case .success(let data):
                    if let data,
                       let image = UIImage(data: data) {
                        single(.success(image))
                    } else {
                        single(.failure(NSError()))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
