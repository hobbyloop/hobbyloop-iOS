//
//  TicketDetailViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/06.
//

import UIKit

import HPCommon
import HPCommonUI
import Tabman
import Pageboy
import RxSwift

class TicketDetailViewController: MainBaseViewController<HomeViewReactor> {
    var view1 = TestViewController()
    var view2 = UIViewController()
    var view3 = UIViewController()
    private lazy var viewControllers = [view1, view2, view3]
    
    private lazy var bodyView: TabmanViewController = {
        return TabmanViewController().then {
            self.view.addSubview($0.view)
            // Create bar
            $0.dataSource = self
            let bar = TMBar.ButtonBar()
            bar.backgroundView.style = .blur(style: .regular)
            bar.backgroundColor = .white
            bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            bar.buttons.customize { (button) in
                button.tintColor = .lightGray // 선택 안되어 있을 때
                button.selectedTintColor = .black // 선택 되어 있을 때
            }
            // 인디케이터 조정
            bar.indicator.weight = .light
            bar.indicator.tintColor = HPCommonUIAsset.deepOrange.color
            bar.indicator.overscrollBehavior = .compress
            bar.layout.alignment = .centerDistributed
            bar.layout.contentMode = .fit
            bar.layout.interButtonSpacing = 35 // 버튼 사이 간격
            
            bar.layout.transitionStyle = .snap // Customize
            
            // Add to view
            $0.addBar(bar, dataSource: self, at: .top)
//            $0.addBar(bar, dataSource: self, at: .custom(view: $0.view, layout: {
//                $0.snp.makeConstraints {
//                    $0.leading.trailing.bottom.equalToSuperview()
//                }
//            }))
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: .detail)
        
        view1.view.backgroundColor = .blue
        view2.view.backgroundColor = .lightGray
        
        configure()
        
        bodyView.view.snp.makeConstraints {
            guard let headerView else { return }
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
}

extension TicketDetailViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }
}
