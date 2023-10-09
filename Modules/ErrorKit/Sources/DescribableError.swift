//
//  DescribableError.swift
//  ErrorKit
//
//  Created by 이정환 on 10/10/23.
//

import Foundation

public protocol DescribableError: Error {
    var description: String { get }
}
