//
//  StampBoardsTargets.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/07.
//

import Foundation

enum StampBoardsTargets {
    case fetchStampBoardList(tabState: TabState)
}

extension StampBoardsTargets: BasicTargetType {
    var baseURL: String {
        return Constants.URL.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchStampBoardList:
            return "v1/stamps/stamp-boards"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchStampBoardList:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var queryParameters: Encodable? {
        var query = [String : String]()
        switch self {
        case .fetchStampBoardList(let tabState):
            query["stampBoardGroup"] = tabState.rawValue
            return query
        }
    }
    
    var bodyParameters: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    var sampleData: Data? {
        switch self {
        default:
            return nil
        }
    }
}

extension StampBoardsTargets: Equatable {
    static func == (lhs: StampBoardsTargets, rhs: StampBoardsTargets) -> Bool {
        switch (lhs, rhs) {
        case (.fetchStampBoardList(let lhsTabState), .fetchStampBoardList(let rhsTabState)):
            return lhsTabState == rhsTabState
        }
    }
}
