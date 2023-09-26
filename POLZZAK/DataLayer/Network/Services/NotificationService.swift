//
//  NotificationService.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/13.
//

import Foundation

final class NotificationService: LinkRequestService {
    let networkService: NetworkServiceProvider
    
    init(networkService: NetworkServiceProvider = NetworkService(requestInterceptor: TokenInterceptor())) {
        self.networkService = networkService
    }
    
    func fetchNotificationList(with startID: Int?) async throws -> (Data, URLResponse) {
        return try await handleResponse(NotificationTargets.fetchNotificationList(startID: startID))
    }
    
    func removeNotification(with notificationID: Int) async throws -> (Data, URLResponse) {
        return try await handleResponse(NotificationTargets.removeNotification(notificationID: notificationID))
    }
    
    func fetchNotificationSettingList() async throws -> (Data, URLResponse) {
        return try await handleResponse(NotificationTargets.fetchNotificationSettingList)
    }
    
    func updateNotificationSettingList(_ notificationSettings: NotificationSettingModel) async throws -> (Data, URLResponse) {
        return try await handleResponse(NotificationTargets.updateNotificationSettingList(notificationSettings))
    }
}
