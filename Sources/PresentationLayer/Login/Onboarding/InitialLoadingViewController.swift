//
//  InitialLoadingViewController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/08/17.
//

import Combine
import UIKit

import Loading
import SnapKit

final class InitialLoadingViewController: UIViewController {
    private let fullScreenLoadingView = FullScreenLoadingView() // TODO: 추후 변경
    private let viewModel = InitialLoadingViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureBinding()
        viewModel.action.send(.load)
    }
    
    private func configureView() {
        view.backgroundColor = .gray100
    }
    
    private func configureLayout() {
        view.addSubview(fullScreenLoadingView)
        
        fullScreenLoadingView.topSpacing = 350
        
        fullScreenLoadingView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureBinding() {
        viewModel.state.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else {
                    self?.fullScreenLoadingView.stopLoading()
                    return
                }
                if isLoading {
                    fullScreenLoadingView.startLoading()
                } else {
                    fullScreenLoadingView.stopLoading()
                }
            }
            .store(in: &cancellables)
        
        viewModel.state.showScreen
            .receive(on: DispatchQueue.main)
            .sink { screen in
                switch screen {
                case .home:
                    AppFlowController.shared.showHome()
                case .login:
                    AppFlowController.shared.showLogin()
                }
            }
            .store(in: &cancellables)
    }
}
