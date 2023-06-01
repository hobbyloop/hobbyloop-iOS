//
//  ExerciseCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/29.
//

import UIKit

import HPThirdParty

class ExerciseCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        return UIStackView().then {
            addSubview($0)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isLayoutMarginsRelativeArrangement = false
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
        }
    }()
    
    private lazy var exerciseImageView: UIImageView = {
        return UIImageView().then {
            $0.image = UIImage(named: "chevron.up.circle.fill")
            stackView.addArrangedSubview($0)
        }
    }()
    
    private lazy var exerciseLabel: UILabel = {
        return UILabel().then {
            $0.text = "테스트"
            stackView.addArrangedSubview($0)
        }
    }()
    
    public func config(_ text: String, _ image: UIImage) {
        exerciseImageView.image = image
        exerciseLabel.text = text
    }
    
}
