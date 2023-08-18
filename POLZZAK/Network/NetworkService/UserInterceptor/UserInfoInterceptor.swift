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
        
        if let accessToken = Keychain().read(identifier: Constants.KeychainKey.accessToken) {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    func retry(previousData: Data, response: URLResponse) async throws -> RetryResult {
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
        Keychain().create(identifier: Constants.KeychainKey.accessToken, value: accessToken)
        Keychain().create(identifier: Constants.KeychainKey.refreshToken, value: refreshToken)
        
        return .retry
    }
}
