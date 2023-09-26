//
//  NotificationTargets.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/10.
//

import Foundation

enum NotificationTargets {
    case fetchNotificationList(startID: Int?)
    case removeNotification(notificationID: Int)
    case fetchNotificationSettingList
    case updateNotificationSettingList(_ notificationSettings: NotificationSettingModel)
}

extension NotificationTargets: BasicTargetType {
    var baseURL: String {
        return Constants.URL.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchNotificationList, .removeNotification:
            return "v1/notifications"
        case .fetchNotificationSettingList, .updateNotificationSettingList:
            return "v1/notifications/settings"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNotificationList, .fetchNotificationSettingList:
            return .get
        case .removeNotification:
            return .delete
        case .updateNotificationSettingList:
            return .patch
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .updateNotificationSettingList:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
    
    var queryParameters: Encodable? {
        var query = [String : Int]()
        switch self {
        case .fetchNotificationList(let startID):
            query["startId"] = startID
            return query
        case .removeNotification(let notificationID):
            query["notificationIds"] = notificationID
            return query
        default:
            return nil
        }
    }
    
    var bodyParameters: Encodable? {
        switch self {
        case .updateNotificationSettingList(let notificationSettings):
            return notificationSettings.toDictionary()
        default:
            return nil
        }
    }
    
    var sampleData: Data? {
        switch self {
        default:
            return nil
        }
    }
}
