// MARK: - Mocks generated from file: Sources/DataLayer/Network/Services/NotificationService.swift at 2023-10-09 17:07:58 +0000

//
//  NotificationService.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/13
import Cuckoo
@testable import POLZZAK

import Foundation






 class MockNotificationService: NotificationService, Cuckoo.ClassMock {
    
     typealias MocksType = NotificationService
    
     typealias Stubbing = __StubbingProxy_NotificationService
     typealias Verification = __VerificationProxy_NotificationService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: NotificationService?

     func enableDefaultImplementation(_ stub: NotificationService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func fetchNotificationList(with startID: Int?) async throws -> (Data, URLResponse) {
        
    return try await cuckoo_manager.callThrows(
    """
    fetchNotificationList(with: Int?) async throws -> (Data, URLResponse)
    """,
            parameters: (startID),
            escapingParameters: (startID),
            superclassCall:
                
                await super.fetchNotificationList(with: startID)
                ,
            defaultCall: await __defaultImplStub!.fetchNotificationList(with: startID))
        
    }
    
    
    
    
    
     override func removeNotification(with notificationID: Int) async throws -> (Data, URLResponse) {
        
    return try await cuckoo_manager.callThrows(
    """
    removeNotification(with: Int) async throws -> (Data, URLResponse)
    """,
            parameters: (notificationID),
            escapingParameters: (notificationID),
            superclassCall:
                
                await super.removeNotification(with: notificationID)
                ,
            defaultCall: await __defaultImplStub!.removeNotification(with: notificationID))
        
    }
    
    
    
    
    
     override func fetchNotificationSettingList() async throws -> (Data, URLResponse) {
        
    return try await cuckoo_manager.callThrows(
    """
    fetchNotificationSettingList() async throws -> (Data, URLResponse)
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.fetchNotificationSettingList()
                ,
            defaultCall: await __defaultImplStub!.fetchNotificationSettingList())
        
    }
    
    
    
    
    
     override func updateNotificationSettingList(_ notificationSettings: NotificationSettingModel) async throws -> (Data, URLResponse) {
        
    return try await cuckoo_manager.callThrows(
    """
    updateNotificationSettingList(_: NotificationSettingModel) async throws -> (Data, URLResponse)
    """,
            parameters: (notificationSettings),
            escapingParameters: (notificationSettings),
            superclassCall:
                
                await super.updateNotificationSettingList(notificationSettings)
                ,
            defaultCall: await __defaultImplStub!.updateNotificationSettingList(notificationSettings))
        
    }
    
    

     struct __StubbingProxy_NotificationService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func fetchNotificationList<M1: Cuckoo.OptionalMatchable>(with startID: M1) -> Cuckoo.ClassStubThrowingFunction<(Int?), (Data, URLResponse)> where M1.OptionalMatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int?)>] = [wrap(matchable: startID) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNotificationService.self, method:
    """
    fetchNotificationList(with: Int?) async throws -> (Data, URLResponse)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func removeNotification<M1: Cuckoo.Matchable>(with notificationID: M1) -> Cuckoo.ClassStubThrowingFunction<(Int), (Data, URLResponse)> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: notificationID) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNotificationService.self, method:
    """
    removeNotification(with: Int) async throws -> (Data, URLResponse)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func fetchNotificationSettingList() -> Cuckoo.ClassStubThrowingFunction<(), (Data, URLResponse)> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNotificationService.self, method:
    """
    fetchNotificationSettingList() async throws -> (Data, URLResponse)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func updateNotificationSettingList<M1: Cuckoo.Matchable>(_ notificationSettings: M1) -> Cuckoo.ClassStubThrowingFunction<(NotificationSettingModel), (Data, URLResponse)> where M1.MatchedType == NotificationSettingModel {
            let matchers: [Cuckoo.ParameterMatcher<(NotificationSettingModel)>] = [wrap(matchable: notificationSettings) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNotificationService.self, method:
    """
    updateNotificationSettingList(_: NotificationSettingModel) async throws -> (Data, URLResponse)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_NotificationService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func fetchNotificationList<M1: Cuckoo.OptionalMatchable>(with startID: M1) -> Cuckoo.__DoNotUse<(Int?), (Data, URLResponse)> where M1.OptionalMatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int?)>] = [wrap(matchable: startID) { $0 }]
            return cuckoo_manager.verify(
    """
    fetchNotificationList(with: Int?) async throws -> (Data, URLResponse)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func removeNotification<M1: Cuckoo.Matchable>(with notificationID: M1) -> Cuckoo.__DoNotUse<(Int), (Data, URLResponse)> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: notificationID) { $0 }]
            return cuckoo_manager.verify(
    """
    removeNotification(with: Int) async throws -> (Data, URLResponse)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func fetchNotificationSettingList() -> Cuckoo.__DoNotUse<(), (Data, URLResponse)> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    fetchNotificationSettingList() async throws -> (Data, URLResponse)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func updateNotificationSettingList<M1: Cuckoo.Matchable>(_ notificationSettings: M1) -> Cuckoo.__DoNotUse<(NotificationSettingModel), (Data, URLResponse)> where M1.MatchedType == NotificationSettingModel {
            let matchers: [Cuckoo.ParameterMatcher<(NotificationSettingModel)>] = [wrap(matchable: notificationSettings) { $0 }]
            return cuckoo_manager.verify(
    """
    updateNotificationSettingList(_: NotificationSettingModel) async throws -> (Data, URLResponse)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NotificationServiceStub: NotificationService {
    

    

    
    
    
    
     override func fetchNotificationList(with startID: Int?) async throws -> (Data, URLResponse)  {
        return DefaultValueRegistry.defaultValue(for: ((Data, URLResponse)).self)
    }
    
    
    
    
    
     override func removeNotification(with notificationID: Int) async throws -> (Data, URLResponse)  {
        return DefaultValueRegistry.defaultValue(for: ((Data, URLResponse)).self)
    }
    
    
    
    
    
     override func fetchNotificationSettingList() async throws -> (Data, URLResponse)  {
        return DefaultValueRegistry.defaultValue(for: ((Data, URLResponse)).self)
    }
    
    
    
    
    
     override func updateNotificationSettingList(_ notificationSettings: NotificationSettingModel) async throws -> (Data, URLResponse)  {
        return DefaultValueRegistry.defaultValue(for: ((Data, URLResponse)).self)
    }
    
    
}




