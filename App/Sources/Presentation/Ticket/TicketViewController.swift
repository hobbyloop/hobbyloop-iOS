//
//  TicketViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit

import HPCommon
import HPCommonUI

class TicketViewController: MainBaseViewController<HomeViewReactor> {

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: headerType)
        configure()
    }
}
