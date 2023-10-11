//
//  InitialLoadingViewModel.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/10/23.
//

import Combine
import Foundation

final class InitialLoadingViewModel {
    enum Action {
        case load
    }
    
    // ???: ReactorKit처럼 Mutate가 필요한건지 생각해보기
    enum Mutate {
        
    }
    
    final class State {
        enum Screen {
            case home
            case login
        }
        
        @Published fileprivate(set) var isLoading = false
        let showScreen = PassthroughSubject<Screen, Never>()
    }
    
    let action = PassthroughSubject<Action, Never>()
    let state = State()
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: InitialLoadingRepository = .init()
    
    init() {
        bind()
    }
    
    private func bind() {
        action.sink { [weak self] action in
            guard let self else { return }
            switch action {
            case .load:
                fetchUserInfo()
            }
        }
        .store(in: &cancellables)
    }
}

extension InitialLoadingViewModel {
    private func fetchUserInfo() {
        state.isLoading = true
        Task {
            let result = await repository.fetchUserInfoAndPostFCMToken()
            state.isLoading = false
            switch result {
            case .showHome:
                state.showScreen.send(.home)
            case .showLogin:
                state.showScreen.send(.login)
            default:
                // TODO: 이 때 토스트나 앱 종료버튼 같이 처리해야할듯
                break
            }
        }
    }
}
