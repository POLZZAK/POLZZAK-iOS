//
//  PolzzakError.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/31.
//

import Foundation

import ErrorKit

enum PolzzakError: DescribableError {
    case repositoryError(code: Int, messages: [String]?)
    case invalidStatusCode(_ statusCode: Int)
    case serviceError(_ statusCode: Int)
    case serverError
    case userDefalutsError
    case unknownError
    case userError
}

extension PolzzakError: CustomStringConvertible {
    var description: String {
        switch self {
        case .serviceError(let statusCode):
            return """
                Error Type: serviceError
                Error Code: \(statusCode)
                Messages: \(HTTPURLResponse.localizedString(forStatusCode: statusCode))
                """
            
        case .repositoryError(let code, let messages):
            return """
                Error Type: RepositoryError
                Error Code: \(code)
                Messages: \(String(describing: messages?.joined(separator: ", ")))
                """
            
        case .invalidStatusCode(let statusCode):
            return """
                Error Type: InvalidStatusCode
                Error Code: \(statusCode)
                Messages: \(HTTPURLResponse.localizedString(forStatusCode: statusCode))
                """
        case .serverError:
            return "ServerError"
            
        case .userDefalutsError:
            return "UserDefalutsError"
            
        case .unknownError:
            return "UnknownError"
        case .userError:
            return "요청에 실패하였습니다. 잠시 후 다시 시도해주세요."
        }
    }
}
