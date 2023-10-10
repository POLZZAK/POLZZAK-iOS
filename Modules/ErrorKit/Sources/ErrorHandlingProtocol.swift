//
//  ErrorHandlingProtocol.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/19.
//

import Combine
import Foundation
import os.log

public protocol ErrorHandlingProtocol {
    var showErrorAlertSubject: PassthroughSubject<Error, Never> { get }
    func handleError(_ error: Error)
}

extension ErrorHandlingProtocol {
    public func handleError(_ error: Error) {
        showErrorAlertSubject.send(error)
        
        if let internalError = error as? DescribableError {
            handleInternalError(internalError)
        } else if let decodingError = error as? DecodingError {
            handleDecodingError(decodingError)
        } else {
            handleUnknownError(error)
        }
        
        logError(error)
    }

    private func handleInternalError(_ error: DescribableError) {
        showErrorAlertSubject.send(error)
    }
    
    private func handleDecodingError(_ error: DecodingError) {
        showErrorAlertSubject.send(error)
    }
    
    private func handleUnknownError(_ error: Error) {
        showErrorAlertSubject.send(error)
    }
    
    private func logError(_ error: Error) {
        switch error {
        case let polzzakError as DescribableError:
            Logger.shared.os_log(log: .polzzakAPI, errorDescription: polzzakError.description)
        case let decodingError as DecodingError:
            Logger.shared.os_log(log: .polzzakAPI, errorDescription: decodingError.description)
        case let localizedError as LocalizedError where localizedError.errorDescription != nil:
            Logger.shared.os_log(log: .polzzakAPI, errorDescription: localizedError.errorDescription!)
        default:
            Logger.shared.os_log(log: .polzzakAPI, errorDescription: error.localizedDescription)
        }
    }
}
