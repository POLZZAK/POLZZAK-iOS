//
//  PushTokenTarget.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/10/23.
//

import Foundation

enum PushTokenTarget {
    case send(token: String)
}

extension PushTokenTarget: BasicTargetType {
    var baseURL: String {
        return Constants.URL.baseURL
    }
    
    var path: String {
        return "v1/push-token"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        if let accessToken = UserInfoManager.PolzzakToken.readToken(type: .access) {
            headers.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        }
        return headers
    }
    
    var queryParameters: Encodable? {
        return nil
    }
    
    var bodyParameters: Encodable? {
        switch self {
        case .send(let token):
            return ["token": token]
        }
    }
    
    var sampleData: Data? {
        return nil
    }
}
