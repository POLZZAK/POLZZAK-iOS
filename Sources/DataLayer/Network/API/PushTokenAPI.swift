//
//  PushTokenAPI.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/10/23.
//

import Foundation

import ErrorKit

struct PushTokenAPI {
    typealias APIReturnType = (Data, URLResponse)
    
    static func sendToken(_ token: String) async throws -> APIReturnType {
        do {
            let target = PushTokenTarget.send(token: token)
            let result = try await NetworkService().request(with: target)
            return result
        } catch {
            os_log(log: .polzzakAPI, errorDescription: String(describing: error))
            throw error
        }
    }
}
