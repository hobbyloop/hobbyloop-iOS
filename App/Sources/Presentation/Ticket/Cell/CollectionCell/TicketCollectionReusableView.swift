//
//  TicketCollectionReusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import UIKit

import HPCommon
import HPCommonUI
import RxSwift

class TicketCollectionReusableView: UICollectionReusableView {
    public var location = PublishSubject<String>()
    public var sortStandard = PublishSubject<FacilitySortType>()
    public var sortButtonTap = PublishSubject<Void>()
    public var loopPassButtonFlag = false
    public var disposeBag = DisposeBag()
    
    private lazy var labelStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 14
        $0.alignment = .leading
        $0.distribution = .fill
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "시설 / 이용권 조회"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
    }
    
    private lazy var descriptionLabel: UILabel = UILabel().then {
        $0.text = "원하는 시설을 구경하고 이용권을 구매해보세요!"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.isLayoutMarginsRelativeArrangement = false
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    private lazy var ticketButton: UIButton = UIButton().then {
        let text = "이용권"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12), range: range)
        attributedString.addAttribute(.foregroundColor, value: loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color : HPCommonUIAsset.lightSeparator.color, range: range)
        $0.setAttributedTitle(attributedString, for: .normal)
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 1
        $0.layer.borderColor = loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color.cgColor : HPCommonUIAsset.lightSeparator.color.cgColor
    }
    
    private lazy var loopPassButton: UIButton = UIButton().then {
        let text = "루프패스"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12), range: range)
        attributedString.addAttribute(.foregroundColor, value: !loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color : HPCommonUIAsset.lightSeparator.color, range: range)
        $0.setAttributedTitle(attributedString, for: .normal)
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 1
        $0.layer.borderColor = !loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color.cgColor : HPCommonUIAsset.lightSeparator.color.cgColor
    }
    
    private lazy var locationStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
        $0.alignment = .center
    }
    
    private lazy var locationImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.locationFilled.image.withTintColor(HPCommonUIAsset.deepOrange.color)
    }
    
    public lazy var locationButton: UIButton = UIButton().then {
        let mainText = "위치를 설정해주세요"
        let attributedString = mainText.stringToAttributed(HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16), UIColor.black)
        $0.setAttributedTitle(attributedString, for: .normal)
        
        var configure = UIButton.Configuration.plain()
        
        $0.addSubview(locationButtonRightLabel)
        
        locationButtonRightLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(0)
            $0.centerY.equalToSuperview()
        }
        
        configure.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: $0.bounds.width + 26)
        $0.configuration = configure
    }
    
    private lazy var locationButtonRightLabel: UILabel = UILabel(frame: CGRect(x: 0,
                                                                               y: 0,
                                                                               width: 0,
                                                                               height: 0)).then {
        let subText = "설정"
        let subAttributedString = subText.stringToAttributed(HPCommonUIFontFamily.Pretendard.light.font(size: 12), UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1))
        let subRange = (subText as NSString).range(of: subText)
        subAttributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: subRange)
        $0.attributedText = subAttributedString
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    public lazy var sortButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.imagePadding = 1
        filled.imagePlacement = .trailing
        return UIButton(configuration: filled, primaryAction: nil).then {
            let text = "별점순"
            
            $0.setAttributedTitle(
                text.stringToAttributed(HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                                        HPCommonUIAsset.lightblack.color
                                       ),for: .normal)
            $0.tintColor = .white
            let size = CGSize(width: 14, height: 14)
            $0.setImage(HPCommonUIAsset.downarrow.image.withRenderingMode(.alwaysOriginal).imageWith(newSize: size), for: .normal)
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        bindRx()
    }
    
    private func initLayout() {
        backgroundColor = .white
        titleLabel.textColor = .black
        descriptionLabel.textColor = .black
        
        [labelStackView, sortButton].forEach {
            addSubview($0)
        }
        
        [titleLabel, descriptionLabel, buttonStackView, locationStackView].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [ticketButton, loopPassButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [locationImageView, locationButton].forEach {
            locationStackView.addArrangedSubview($0)
        }
        
        labelStackView.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
            $0.trailing.equalTo(sortButton.snp.leading)
        }
        
        ticketButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(69)
        }
        
        loopPassButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(69)
        }
        
        sortButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        locationImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        loopPassButton.addTarget(self, action: #selector(loopPassClick), for: .touchDown)
        ticketButton.addTarget(self, action: #selector(loopPassClick), for: .touchDown)
        
    }
    
    private func bindRx() {
        
        location.subscribe { loc in
            guard let loc = loc.element else { return }
            let attributedString = loc.stringToAttributed(HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16), UIColor.black)
            self.locationButton.setAttributedTitle(attributedString, for: .normal)
            
            let subText = "변경"
            let subAttributedString = subText.stringToAttributed(HPCommonUIFontFamily.Pretendard.light.font(size: 12), UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1))
            let subRange = (subText as NSString).range(of: subText)
            subAttributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: subRange)
            self.locationButtonRightLabel.attributedText = subAttributedString
        }.disposed(by: disposeBag)
        
        sortStandard
            .subscribe {
                guard let element = $0.element else { return }
                var title = ""
                switch element {
                case .recently:
                    title = element.rawValue
                case .amount:
                    title = element.rawValue
                case .score:
                    title = element.rawValue
                case .review:
                    title = element.rawValue
                }
                
                self.sortButton.setAttributedTitle(
                    title.stringToAttributed(HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                                             HPCommonUIAsset.lightblack.color
                                            ),for: .normal
                )
            }
            .disposed(by: disposeBag)
        
        sortButton
            .rx
            .tap
            .bind(to: sortButtonTap)
            .disposed(by: disposeBag)
    }
    
    @objc private func loopPassClick() {
        loopPassButtonFlag.toggle()
        
        let loopText = "루프패스"
        
        loopPassButton.setAttributedTitle(loopText.stringToAttributed(
            HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12),
            !loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color : HPCommonUIAsset.lightSeparator.color
        ),for: .normal)
        loopPassButton.layer.borderColor = !loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color.cgColor : HPCommonUIAsset.lightSeparator.color.cgColor
        
        let text = "이용권"
        ticketButton.setAttributedTitle(text.stringToAttributed(
            HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12),
            loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color : HPCommonUIAsset.lightSeparator.color
        ),for: .normal)
        
        ticketButton.layer.borderColor = loopPassButtonFlag ? HPCommonUIAsset.deepOrange.color.cgColor : HPCommonUIAsset.lightSeparator.color.cgColor
    }
    
}
