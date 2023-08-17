//
//  FacilityInfoCollectionReusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/08.
//

import UIKit

import HPCommonUI
import RxSwift

class FacilityInfoCollectionReusableView: UICollectionReusableView {
    private var centerImageView: UIImageView = {
        return UIImageView()
    }()
    
    private var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.distribution = .fillProportionally
            $0.spacing = 16
        }
    }()
    
    private var companyView: UIView = {
        return UIView()
    }()
    
    private var titleStackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 8
            $0.axis = .vertical
            $0.alignment = .leading
        }
    }()
    
    private var titleAndIconStackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 5
            $0.axis = .horizontal
            $0.alignment = .center
            $0.snp.makeConstraints {
                $0.height.equalTo(24)
            }
        }
    }()
    
    private var loopPassLabel: UILabel = {
        return UILabel().then {
            $0.text = "루프패스"
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 10)
            $0.textColor = .white
            $0.backgroundColor = HPCommonUIAsset.deepOrange.color.withAlphaComponent(1)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.width.equalTo(50)
            }
        }
    }()

    private var refundableCompanyLabel: UILabel = {
        return UILabel().then {
            $0.text = "중도환불 가능업체"
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 10)
            $0.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = HPCommonUIAsset.separator.color.withAlphaComponent(1).cgColor
            $0.layer.borderWidth = 1
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.width.equalTo(90)
            }
        }
    }()
    
    private var titleLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 18)
        }
    }()
    
    private var descriptionLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
            $0.textColor = .black.withAlphaComponent(0.45)
        }
    }()
    
    private var communicationStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 15
        }
    }()
    
    private var callButton: UIButton = {
        return UIButton().then {
            $0.setImage(HPCommonUIAsset.callFilled.image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }()
    
    private var messageButton: UIButton = {
        return UIButton().then {
            $0.setImage(HPCommonUIAsset.textFilled.image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }()
    
    private var workTimeButton: UIButton = {
        return UIButton().then {
            var configure = UIButton.Configuration.plain()
            let imageSize = CGSize(width: 12, height: 12)
            configure.image = HPCommonUIAsset.downarrow.image.imageWith(newSize: imageSize)
            configure.imagePlacement = .trailing
            configure.imagePadding = 6
            configure.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: $0.bounds.width + 26, bottom: 0, trailing: 0)
            configure.titlePadding = 6
            $0.configuration = configure
            
            let fullText = "운영시간"
            let range = (fullText as NSString).range(of: "운영시간")
            let attributedString = NSMutableAttributedString(string: fullText)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 16), range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
            $0.tintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    private var operatingAndReviewView: UIView = {
        return UIView()
    }()
    
    private var reviewView: UIView = {
        return UIView()
    }()
    
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
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        backgroundColor = .white
        
        [centerImageView, mainStackView].forEach {
            addSubview($0)
        }
        
        [companyView, operatingAndReviewView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [titleStackView, communicationStackView].forEach {
            companyView.addSubview($0)
        }
        
        [titleLabel, loopPassLabel, refundableCompanyLabel].forEach {
            titleAndIconStackView.addArrangedSubview($0)
        }
        
        [callButton, messageButton].forEach {
            communicationStackView.addArrangedSubview($0)
        }
        
        [titleAndIconStackView, descriptionLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [workTimeButton, reviewView].forEach {
            operatingAndReviewView.addSubview($0)
        }
        
        [starImageView, starLabel, starArrowImageView].forEach {
            reviewView.addSubview($0)
        }
        
        centerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(236)
        }
        
        companyView.snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(centerImageView.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-19)
            $0.height.equalTo(83)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        communicationStackView.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
        }
        
        workTimeButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
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
        
        reviewView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
        }
        
        reviewView.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                print("tap Star Review View")
            }.disposed(by: disposeBag)
        
    }
    
    public func configure() {
        let number = 123
        let text = "\(number)개의 리뷰"
        centerImageView.image = UIImage(named: "TicketTestImage")?.withRenderingMode(.alwaysOriginal)
        titleLabel.text = "발란스 스튜디오"
        descriptionLabel.text = "서울 강남구 압구정로50길 8 2층"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.regular.font(size: 14), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1), range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        starLabel.attributedText = attributedString
        
        let leftImageView = UIImageView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 20,
                                                      height: 20))
        leftImageView.image?.withRenderingMode(.alwaysOriginal)
        leftImageView.image = HPCommonUIAsset.watch.image.withRenderingMode(.alwaysOriginal)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.layer.masksToBounds = true
        workTimeButton.addSubview(leftImageView)
    }
}
