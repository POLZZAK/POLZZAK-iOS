//
//  NetworkResult.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/16.
//

import Foundation


enum NetworkResult<Success, Failure> {
    case success(Success?)
    case failure(Failure)
}
