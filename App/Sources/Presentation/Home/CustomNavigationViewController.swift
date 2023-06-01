//
//  CustomNavigationViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/26.
//

import UIKit

import RxSwift
import RxCocoa

class CustomNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
