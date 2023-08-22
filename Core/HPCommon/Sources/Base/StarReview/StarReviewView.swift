//
//  StarReviewView.swift
//  HPCommon
//
//  Created by 김진우 on 2023/08/21.
//

import UIKit
import HPCommonUI

/// Notice: 별이 달리고 리뷰 개수가 적혀있는 뷰 입니다.
/// Layout: Width: 110, Height: 20
/// How use?: View에 RxGesture를 활용해서 액션을 추가해 사용합니다.
/// Configure에 리뷰 개수를 넣어줍니다.
public final class StarReviewView: UIView {
    private var starImageView: UIImageView = {
        return UIImageView().then {
            $0.tintColor = UIColor(red: 255/255, green: 212/255, blue: 75/255, alpha: 1)
            $0.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    private var starLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }()
    
    private var starArrowImageView: UIImageView = {
        return UIImageView().then {
            let size = CGSize(width: 12, height: 12)
            $0.tintColor = .black
            $0.image = UIImage(systemName: "chevron.right")?.imageWith(newSize: size).withRenderingMode(.alwaysOriginal)
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        [starImageView, starLabel, starArrowImageView].forEach {
            addSubview($0)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(13)
            $0.centerY.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.top.bottom.equalToSuperview()
        }
        
        starArrowImageView.snp.makeConstraints {
            $0.leading.equalTo(starLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    public func configure(_ num: Int) {
        let text = "\(num)개의 리뷰"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.regular.font(size: 14), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1), range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        starLabel.attributedText = attributedString
    }
}
