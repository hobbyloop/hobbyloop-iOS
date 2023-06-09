//
//  MyPageViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/06/03.
//

import UIKit
import SnapKit
import HPCommonUI

var dummyCoupons = [
    DummyCoupon(companyName: "밸런스 스튜디오", count: 10, start: .now, end: .now),
    DummyCoupon(companyName: "SARA 요가 스튜디오", count: 5, start: .now, end: .now)
]

class MyPageViewController: UIViewController {
    let couponListView = CouponListView(coupons: dummyCoupons)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(couponListView)
        view.backgroundColor = .systemBackground
        couponListView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(211)
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
