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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let couponView = CouponView(companyName: "밸런스 스튜디오", count: 10, start: .now, end: .now)
        view.addSubview(couponView)
        
        couponView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-58)
            make.height.equalTo(179)
            make.center.equalTo(view.snp.center)
        }
        // Do any additional setup after loading the view.
    }

}
