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


class HomeViewController: BaseViewController<HomeViewReactor> {
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: Configure
    private func configure() {
        self.view.backgroundColor = .systemBackground
    }
    
}
