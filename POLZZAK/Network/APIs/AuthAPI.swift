//
//  AuthAPI.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/06/04.
//

import Foundation

struct AuthAPI: APIProtocol {
    let networkService: NetworkServiceProvider = NetworkService(requestAdapter: AuthAdapter(), requestRetrier: AuthRetrier())
    
    func authorize() async throws -> TokenResponseDTO {
        let endPoint = Endpoint<TokenResponseDTO>(baseURL: "https://api.polzzak.co.kr/", path: "api/v1/users/me", method: .get)
        return try await networkService.request(with: endPoint)
    }
}

struct RefreshTokenAPI: APIProtocol {
    let networkService: NetworkServiceProvider = NetworkService(requestAdapter: RefreshTokenAdapter())
    
    func refreshToken() async throws -> TokenResponseDTO {
        let endPoint = Endpoint<TokenResponseDTO>(baseURL: "https://api.polzzak.co.kr/", path: "api/v1/users/me", method: .get)
        return try await networkService.request(with: endPoint)
    }
}