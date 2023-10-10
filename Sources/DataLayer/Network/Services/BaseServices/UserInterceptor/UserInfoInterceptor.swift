//
//  UserInfoInterceptor.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/08/18.
//

import Foundation

class UserInfoInterceptor: RequestInterceptor {
    func adapt(for urlRequest: URLRequest) async throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let accessToken = UserInfoManager.PolzzakToken.readToken(type: .access) {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    func retry(previousData: Data, response: URLResponse) async throws -> RetryResult {
        // TODO: statusCode가 400 말고 그냥 UserInfo get이 실패했을 경우에 retry 하는게 좋지않을까?
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 400,
              let data = try? JSONDecoder().decode(BaseResponseDTO<String>.self, from: previousData),
              let accessToken = data.data,
              let refreshToken = httpResponse.getRefreshTokenFromCookie()
        else {
            return .doNotRetry
        }
        
        print("UserInfoInterceptor -")
        print("🥬🪙 refreshed accessToken: ", accessToken)
        print("🥬🪙 refreshed refreshToken: ", refreshToken)
        UserInfoManager.PolzzakToken.saveToken(accessToken, type: .access)
        UserInfoManager.PolzzakToken.saveToken(refreshToken, type: .refresh)
        
        return .retry
    }
}
