//
//  TicketInstructorProfileCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import UIKit

import HPCommonUI
import Then
import SnapKit
import ReactorKit
import RxCocoa

public final class TicketInstructorProfileCell: UICollectionViewCell {
    
    //MARK: Property
    public typealias Reactor = TicketInstructorProfileCellReactor
    public var disposeBag: DisposeBag = DisposeBag()
    
    private let profileImage: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private lazy var pageControl: HPPageControl = HPPageControl().then {
        //TODO: numberOfPages Reactor State로 처리
        $0.numberOfPages = 3
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [profileImage, pageControl].forEach {
            self.contentView.addSubview($0)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(270)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(7)
            $0.height.equalTo(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
}


extension TicketInstructorProfileCell: ReactorKit.View {
    
    public func bind(reactor: Reactor) {
        
        
        //TODO: API 통신 후 Image URL로 Binding 처리하도록 수정
        reactor.state
            .map { $0.imageURL }
            .map { HPCommonUIImages.Image(named: $0, in: HPCommonUIResources.bundle, with: nil) }
            .asDriver(onErrorJustReturn: UIImage())
            .drive(profileImage.rx.image)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$currentPage)
            .observe(on: MainScheduler.asyncInstance)
            .asDriver(onErrorJustReturn: 0)
            .drive(pageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
        
    }
    
}
