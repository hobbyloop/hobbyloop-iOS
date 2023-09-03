//
//  ExerciseView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/29.
//

import UIKit

import RxSwift
import Then

public final class ExerciseView: UIView {
    private let items: CGFloat = 4
    private let listObserver = Observable.of([
        testItem(name: "헬스/PT", image: UIImage(systemName: "chevron.up.circle")!),
        testItem(name: "필라테스", image: UIImage(systemName: "chevron.down")!),
        testItem(name: "테니스", image: UIImage(systemName: "chevron.down.circle")!),
        testItem(name: "골프", image: UIImage(systemName: "chevron.down.square.fill")!)
    ])
    private let disposeBag = DisposeBag()
    
    public lazy var backgroundView: UIView = {
        return UIView().then {
            addSubview($0)
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 60
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(items * (74 + 12) + 64 + 10)
            }
        }
    }()
    
    private lazy var searchLabel: UILabel = {
        return UILabel().then {
            backgroundView.addSubview($0)
            $0.text = "어떤 운동을 찾고있나요?"
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.centerX.top.equalToSuperview()
                $0.height.equalTo(64)
            }
        }
    }()
    
    public lazy var tableView: UITableView = {
        return UITableView().then {
            backgroundView.addSubview($0)
            $0.register(ExerciseCell.self, forCellReuseIdentifier: "ExerciseCell")
            $0.clipsToBounds = false
            $0.backgroundColor = .clear
            $0.contentInset = .zero
            $0.delegate = self
            $0.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            $0.snp.makeConstraints {
                $0.top.equalTo(searchLabel.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }()
    
    public init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        listObserver
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items) { tableView, row, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: IndexPath(row: row, section: 0)) as? ExerciseCell else { return UITableViewCell() }
                cell.config(item.name, item.image)
                if row == 3 {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude / 2)
                }
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}

extension ExerciseView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        74
    }
}

struct testItem {
    let name: String
    let image: UIImage
}
