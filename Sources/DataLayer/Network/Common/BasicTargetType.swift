//
//  BasicTargetType.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/06/19.
//

import Foundation

protocol BasicTargetType: TargetType {
    var bodyParameters: Encodable? { get }
}

extension BasicTargetType {
    func getURLRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        print("😂", bodyParameters)
        // httpBody
        do {
            if let bodyParameters = try bodyParameters?.toDictionary() {
                print("💀 ", bodyParameters)
                if !bodyParameters.isEmpty {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
                }
            }
        } catch {
            print("💀 ", error)
        }

        // httpMethod
        urlRequest.httpMethod = method.rawValue

        // header
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        return urlRequest
    }
}
