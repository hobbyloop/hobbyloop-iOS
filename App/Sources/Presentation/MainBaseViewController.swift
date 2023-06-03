//
//  MainBaseViewContro.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit

import HPCommon
import HPCommonUI
import ReactorKit

class MainBaseViewController<T: ReactorKit.Reactor>: BaseViewController<T>, UIGestureRecognizerDelegate {
    
    //MARK: Property
    public typealias Reactor = T
    
    //MARK: Initialization
    public init(reactor: T? = nil, HeaderType: HeaderType = .none) {
        super.init()
        self.reactor = reactor
        self.headerType = HeaderType
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var headerView: HeaderView?
    
    public lazy var exerciseListView: ExerciseView = {
        return ExerciseView()
    }()
    
    private var toggle: Bool = true
    public var headerType: HeaderType = .none
    
    open func configure() {
        if let headerView {
            view.addSubview(headerView)
            headerView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(self.view)
                $0.height.equalTo(60 + UIApplication.shared.safeAreaTop)
            }
            bindRx()
        }
    }
    
    private func bindRx() {
        switch headerType {
            
        case .main:
            headerView!.menuBar
                .rx.tap
                .bind { [weak self] in
                    guard let `self` = self else { return }
                    if toggle {
                        exerciseViewAdd()
                        toggle = false
                    } else {
                        touchView()
                    }
                }.disposed(by: disposeBag)
            
            headerView?.alarm
                .rx.tap
                .subscribe { [weak self] _ in
                    guard let `self` = self else { return }
                    self.navigationController?.pushViewController(AlarmViewController(HeaderType: .detail), animated: false)
                }.disposed(by: disposeBag)

            headerView?.searchButton
                .rx.tap
                .bind { [weak self] _ in
                    guard let `self` = self else { return }
                    self.navigationController?.pushViewController(SearchViewController(HeaderType: .detail), animated: false)
                }.disposed(by: disposeBag)
            
            Observable
                .merge(
                    exerciseListView.rx.tapGesture(configuration: { [weak self] gestureRecognizer, delegate in
                        guard let `self` = self else { return }
                        gestureRecognizer.delegate = self
                        delegate.simultaneousRecognitionPolicy = .never
                    })
                    .asObservable(),
                    exerciseListView.backgroundView.rx.tapGesture(configuration: { [weak self] gestureRecognizer, delegate in
                        guard let `self` = self else { return }
                        gestureRecognizer.delegate = self
                        delegate.simultaneousRecognitionPolicy = .never
                    })
                    .asObservable()
                )
                .when(.recognized)
                .bind { [weak self] _ in
                    guard let `self` = self else { return }
                    self.touchView()
                }
                .disposed(by: self.disposeBag)
        case .detail:
            headerView!.backButton
                .rx.tap
                .bind {
                    self.navigationController?.popViewController(animated: false)
                }.disposed(by: disposeBag)
        case .none:
            break
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard touch.view?.isDescendant(of: self.exerciseListView.backgroundView) == false else { return false }
        return true
    }
}

private extension MainBaseViewController {
    private func touchView() {
        exerciseListView.removeFromSuperview()
        toggle.toggle()
        tabBarController?.tabBar.layer.zPosition = 0
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    private func exerciseViewAdd() {
        self.view.addSubview(exerciseListView)
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        tabBarController?.tabBar.layer.zPosition = -1
        exerciseListView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        exerciseListView.snp.makeConstraints {
            $0.top.equalTo(self.headerView!.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}
