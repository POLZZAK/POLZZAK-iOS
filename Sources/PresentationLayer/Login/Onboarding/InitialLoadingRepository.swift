//
//  InitialLoadingRepository.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/10/23.
//

import Foundation

import Extension

final class InitialLoadingRepository {
    private let dataMapper = StampBoardDetailMapper()
    
    func fetchUserInfoAndPostFCMToken() async -> InitialLoadingRepositoryResult {
        do {
            let result = try await UserAPI.getUserInfo()
            let handledResult = try handleUserInfoResult(result: result)
            guard case .showHome = handledResult else {
                return handledResult
            }
            guard let token = UserInfoManager.FCMToken.readToken() else {
                return .fail
            }
            let sendingTokenResult = try await PushTokenAPI.sendToken(token)
            let handledSendingTokenResult = try handleSendingTokenResult(result: sendingTokenResult)
            return handledSendingTokenResult
        } catch {
            os_log(log: .polzzakAPI, errorDescription: String(describing: error))
            if let urlError = error as? URLError {
                // TODO: URLError의 timedOut, networkConnectionLost, notConnectedToInternet에 대해 공통처리 하는 부분은 빼도 좋지 않을까?
                return .urlError(urlError)
            }
            return .unknown(error)
        }
    }
    
    private func handleUserInfoResult(result: (Data, URLResponse)) throws -> InitialLoadingRepositoryResult {
        let (data, response) = result
        guard let httpResponse = response as? HTTPURLResponse else { return .emptyStatusCode }
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200..<300:
            let dto = try JSONDecoder().decode(UserInfoDTO.self, from: data)
            let data = dto.data
            UserInfoManager.UserInfo.saveUserInfo(data)
            return .showHome
        default: // TODO: UserInfo 조회에 실패한 경우는 다시 로그인 보다 더 좋은 방법이 없을까?
            UserInfoManager.PolzzakToken.deleteToken(type: .access)
            UserInfoManager.PolzzakToken.deleteToken(type: .refresh)
            UserInfoManager.FCMToken.deleteToken()
            return .showLogin
        }
    }
    
    private func handleSendingTokenResult(result: (Data, URLResponse)) throws -> InitialLoadingRepositoryResult {
        let (_, response) = result
        guard let httpResponse = response as? HTTPURLResponse else { return .emptyStatusCode }
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200..<300:
            return .showHome
        default: 
            return .fail
        }
    }
}

enum InitialLoadingRepositoryResult {
    case showHome
    case showLogin
    case fail
    case urlError(URLError)
    case emptyStatusCode
    case unknown(Error)
}
