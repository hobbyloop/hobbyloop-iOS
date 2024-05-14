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
    private let backButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14)), for: [])
        $0.configuration?.contentInsets = .init(top: 6, leading: 9, bottom: 6, trailing: 9)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "포인트"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}

// MARK: - table view data source
extension PointViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HPHistoryCell.identifier) as! HPHistoryCell
        cell.dateText = "03.10"
        cell.title = "필라피티 스튜디오"
        cell.historyContent = "+30,000P"
        cell.remainingAmountText = "70,000P"
        
        return cell
    }
}
