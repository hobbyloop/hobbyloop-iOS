//
//  HomeViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPExtensions
import RxSwift
import RxCocoa
import RxGesture


class HomeViewController: MainBaseViewController<HomeViewReactor> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: headerType)
        configure()
        
    }
    
}
