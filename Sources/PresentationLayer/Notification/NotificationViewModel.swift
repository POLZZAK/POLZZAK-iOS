//
//  NotificationViewModel.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/07/11.
//

import Combine
import Foundation

import InfiniteScrollLoader
import Loading
import PullToRefresh

final class NotificationViewModel: PullToRefreshProtocol, InfiniteScrollingViewModel, LoadingViewModelProtocol, ErrorHandlingProtocol {
    var cancellables = Set<AnyCancellable>()
    var isApiFinishedLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    var didEndDraggingSubject = PassthroughSubject<Bool, Never>()
    var shouldEndRefreshing = PassthroughSubject<Void, Never>()
    var rechedBottomSubject = CurrentValueSubject<Bool, Never>(false)
    
    private let repository: NotificationDataRepository
    var userType: UserType
    @Published var saveStartID: Int? = nil
    @Published var notificationList: [NotificationData] = []
    @Published var notificationSettingList: [SettingItem] = []
    @Published var SettingBool: Bool? = nil
    
    var isSkeleton = CurrentValueSubject<Bool, Never>(true)
    var isCenterLoading = CurrentValueSubject<Bool, Never>(false)
    var showErrorAlertSubject = PassthroughSubject<Error, Never>()
    
    init(repository: NotificationDataRepository) {
        self.repository = repository
        
        let userInfo = UserInfoManager.readUserInfo()
        userType = (userInfo?.memberType.detail == "아이" ? .child : .parent)
        
        setupPullToRefreshBinding()
        setupBottomRefreshBindings()
    }
    
    func setupBottomRefreshBindings() {
        rechedBottomSubject
            .filter { $0 }
            .filter { [weak self] _ in
                guard let self else { return false }
                return (saveStartID != nil) && self.notificationList.count >= 10
            }
            .sink { [weak self] _ in
                self?.fetchNotificationList(for: true)
            }
            .store(in: &cancellables)
    }
    
    func reloadData(for centerLoading: Bool = false) {
        guard false == isSkeleton.value else { return }
        saveStartID = nil
        fetchNotificationList(for: centerLoading, more: false)
    }
    
    func fetchNotificationList(for centerLoading: Bool = false, isFirst: Bool = false, more: Bool = true) {
        if false == more {
            saveStartID = nil
        }
        
        Task {
            defer {
                hideLoading(for: centerLoading)
                isApiFinishedLoadingSubject.send(true)
            }
            
            if true == isCenterLoading.value {
                return
            }
            
            showLoading(for: centerLoading)
            
            if true == isFirst {
                self.shouldEndRefreshing.send()
            }
            
            do {
                isApiFinishedLoadingSubject.send(false)
                let result = try await repository.fetchNotificationList(with: saveStartID)
                guard let result else { return }
                if false == more {
                    saveStartID = result.startID
                    notificationList = result.notificationList ?? []
                } else {
                    if saveStartID == nil {
                        notificationList = result.notificationList ?? []
                    } else {
                        var currentList = notificationList
                        currentList.append(contentsOf: result.notificationList ?? [])
                        notificationList = currentList
                        saveStartID = result.startID
                    }
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func removeNotification(with index: Int) async {
        do {
            if notificationList[index].status != .requestLink {
                let notificationID = notificationList[index].id
                try await repository.removeNotification(with: notificationID)
                removeData(for: notificationID)
            }
        } catch {
            handleError(error)
        }
    }
    
    func removeData(for notificationID: Int) {
        guard let index = notificationList.map( {$0.id}).firstIndex(of: notificationID) else { return }
        notificationList.remove(at: index)
    }
    
    func linkApproveDidTap(for memberID: Int) async {
        do {
            try await repository.approveLinkRequest(to: memberID)
            removeData(for: memberID)
        } catch {
            handleError(error)
        }
    }
    
    func linkRejectDidTap(for memberID: Int) async {
        do {
            try await repository.rejectLinkRequest(to: memberID)
            removeData(for: memberID)
        } catch {
            handleError(error)
        }
    }
    
    func fetchNotificationSettingList() {
        Task {
            defer {
                hideLoading()
            }
            
            if true == isCenterLoading.value {
                return
            }
            
            showLoading()
            
            do {
                let result = try await repository.fetchNotificationSettingList()
                guard let result else { return }
                notificationSettingList = result.toOrderedArray(userType: userType)
            } catch {
                handleError(error)
            }
        }
    }
    
    func indexToNotificationSettingTitle(_ index: Int) -> String {
        guard index >= 0 && index < notificationSettingList.count else {
            return ""
        }
        
        return notificationSettingList[index].type.titleText(userType: userType)
    }
    
    func indexToNotificationSettingDetail(_ index: Int) -> String {
        guard index >= 0 && index < notificationSettingList.count else {
            return ""
        }
        
        return notificationSettingList[index].type.detailText(userType: userType)
    }
    
    func indexToNotificationSettingisEnabled(_ index: Int) -> Bool {
        guard index >= 0 && index < notificationSettingList.count else {
            return false
        }
        
        return notificationSettingList[index].isEnabled
    }
    
    func updateNotificationSetting(index: Int? = nil, bool: Bool? = nil) {
        Task {
            defer {
                hideLoading()
            }
            
            if true == isCenterLoading.value {
                return
            }
            
            showLoading()
            
            do {
                if let index {
                    let requestModel = requestSettingModel(index: index)
                    try await repository.updateNotificationSettingList(requestModel)
                    notificationSettingList[index].isEnabled = !notificationSettingList[index].isEnabled
                } else if let bool {
                    let requestModel = requestAllSettingModel(bool: bool)
                    try await repository.updateNotificationSettingList(requestModel)
                    notificationSettingList = requestAllSettingModel(bool: bool).toOrderedArray(userType: userType)
                } else {
                    throw PolzzakError.unknownError
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func requestAllSettingModel(bool: Bool) -> NotificationSettingModel {
        return NotificationSettingModel(settingItems: notificationSettingList, bool: bool)
    }
    
    func requestSettingModel(index: Int) -> NotificationSettingModel {
        let data = notificationSettingList[index]
        return NotificationSettingModel(type: data.type, value: !data.isEnabled)
    }
}
