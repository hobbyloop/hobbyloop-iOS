//
//  MyPageViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/06/03.
//

import UIKit
import SnapKit
import HPCommonUI

class MyPageViewController: UIViewController {
    let couponView = CouponView(companyName: "밸런스 스튜디오", count: 10, start: .now, end: .now)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(couponView)

        couponView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-58)
            make.height.equalTo(179)
            make.center.equalTo(view.snp.center)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        couponView.applyCornerRadius()
    }
}
