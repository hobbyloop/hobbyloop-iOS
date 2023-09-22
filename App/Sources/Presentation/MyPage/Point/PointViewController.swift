//
//  PointViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/22.
//

import UIKit
import HPCommonUI

final class PointViewController: UIViewController {
    private let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 22)).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image, for: .normal)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavigationBar()
        addActions()
    }
    
    // MARK: - layout
    private func configNavigationBar() {
        navigationItem.title = "포인트"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - add button actions
    private func addActions() {
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
    
    // MARK: - button actions
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
