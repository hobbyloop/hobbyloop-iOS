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
    private var view1 = FacilityInfoViewController()
    private var view2 = ClassInfoViewController()
    private lazy var viewControllers = [view1, view2]
    
    private lazy var bodyView: TabmanViewController = {
        return TabmanViewController().then {
            // Create bar
            $0.dataSource = self
            let bar = TMBar.ButtonBar()
            bar.backgroundView.style = .blur(style: .regular)
            bar.backgroundColor = .white
            bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 17.0, bottom: 0.0, right: 17.0)
            bar.buttons.customize { (button) in
                button.tintColor = UIColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1) // 선택 안되어 있을 때
                button.selectedTintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1) // 선택 되어 있을 때
                button.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
            }
            // 인디케이터 조정
            bar.indicator.weight = .light
            bar.indicator.tintColor = HPCommonUIAsset.deepOrange.color.withAlphaComponent(0.4)
            bar.indicator.overscrollBehavior = .bounce
            bar.layout.alignment = .leading
            bar.layout.contentMode = .fit
            bar.layout.transitionStyle = .snap // Customize
            
            // Add to view
            $0.addBar(bar, dataSource: self, at: .top)
        }
    }()
    
    private lazy var paymentButton: UIButton = {
        return UIButton().then {
            $0.backgroundColor = HPCommonUIAsset.deepOrange.color.withAlphaComponent(1)
            $0.setTitle("결제하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
        }
    }()
    
    private var viewIndex: Int = 0
    
    init(_ index: Int = 0) {
        super.init()
        viewIndex = index
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.topViewController?.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: .detail)
        
        configure()
        
        [bodyView.view, paymentButton].forEach {
            self.view.addSubview($0)
        }
        
        bodyView.view.snp.makeConstraints {
            guard let headerView else { return }
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        paymentButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().inset(UIApplication.shared.safeAreaBottom)
            $0.height.equalTo(56)
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
        return .at(index: viewIndex)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        var title : String {
            switch index {
            case 0:
                return "시설정보"
            case 1:
                return "이용권‧수업 정보"
            default :
                return ""
            }
        }
        
        let barItem = TMBarItem(title: title)
        
        return barItem
    }
}
