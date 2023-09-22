//
//  PointViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/22.
//

import UIKit
import HPCommonUI

class PointViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavigationBar()
    }
    
    private func configNavigationBar() {
        navigationItem.title = "포인트"
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 22))
        backButton.setImage(HPCommonUIAsset.leftarrow.image, for: .normal)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
