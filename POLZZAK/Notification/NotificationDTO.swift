//
//  NotificationDTO.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/07/12.
//

import UIKit

//TODO: - API문서 나오면 싹 바꿔야함
struct NotificationDTO: Decodable {
    let type: String
    let date: String
    let description: String
    let link: String
    let sender: String
    let profileURL: String
    let stampBoardName: String
    let rewardName: String
    let level: String
    let isNew: Bool
}

//TODO: - 시간에 대한 테스트를 위해 만든것
struct NotificationDummyDataGenerator {
    static func generateDummyData() -> [NotificationModel] {
        var now = Date()
        var dummyDates: [Date] = [
            now,
            now.addingTimeInterval(-10),    // +10 seconds
            now.addingTimeInterval(-30),    // +30 seconds
            now.addingTimeInterval(-60),    // +1 minute
            now.addingTimeInterval(-60*60), // +1 hour
            now.addingTimeInterval(-60*60*58.33), // +3500 minutes
            now.addingTimeInterval(-60*60*60), // +3600 minutes
            now.addingTimeInterval(-60*60*24) // +1 day
        ]
        
        for _ in 8..<NotificationType.allCases.count {
            now = now.addingTimeInterval(-60*60*24) // Add 1 day
            dummyDates.append(now)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dummyNotificationDTOs = NotificationType.allCases.enumerated().map { index, type in
            
            var description: String
            switch type {
            case .requestLink, .completedLink:
                description = "스치면인연스며들면스폰지밥"
            case .levelUp:
                description = "5"
            case .levelDown:
                description = "4"
            case .requestStamp, .completedStampBoard, .createStampBoard, .receivedCoupon:
                description = "3일 1커밋 프로젝트"
            case .requestReward, .receivedReward, .oneDayLeftReward, .brokenReward, .requestCompleteTap:
                description = "갤럭시북"
            }
            
            let temp = NotificationDTO(
                type: type.rawValue,
                date: dateFormatter.string(from: dummyDates[index]),
                description: description,
                link: "https://www.example.com/\(type.rawValue)",
                sender: "스티븐 잡스",
                profileURL: "https://as1.ftcdn.net/v2/jpg/02/16/27/30/1000_F_216273016_EBLZScZQ5Zu5Yw7W3RO48bdYbsynnjur.jpg",
                stampBoardName: "Test Stamp Board \(index + 1)",
                rewardName: "Test Reward \(index + 1)",
                level: "Test Level \(index + 1)",
                isNew: [true, false].randomElement() ?? false
            )
            return try! NotificationModel(from: temp)
        }
        return dummyNotificationDTOs
    }
}
