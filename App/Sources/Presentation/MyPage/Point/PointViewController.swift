//
//  PointViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/22.
//

import UIKit
import HPCommonUI

final class PointViewController: UIViewController {
    // MARK: - navigation bar back button
    private let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 22)).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image, for: .normal)
    }
    
    // MARK: - background view
    private let backgroundView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.lightBackground.color
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        configNavigationBar()
        addActions()
    }
    
    // MARK: - layout
    private func configNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
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
