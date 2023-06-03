//
//  CustomNavigationViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/26.
//

import UIKit

import HPCommonUI
import RxSwift
import RxCocoa

public class CustomNavigationViewController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
