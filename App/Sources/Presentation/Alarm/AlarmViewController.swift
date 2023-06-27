//
//  AlarmViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit

import HPCommon
import RxSwift
import RxCocoa

class AlarmViewController: MainBaseViewController<HomeViewReactor> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: headerType)
        configure()
    }
}
