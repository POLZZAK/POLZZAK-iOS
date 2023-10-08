//
//  PullToRefreshModuleTests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble
@testable import PullToRefresh

final class PullToRefreshTests: XCTestCase {

    var customRefreshControl: CustomRefreshControl!
        
        override func setUp() {
            super.setUp()
            customRefreshControl = CustomRefreshControl()
        }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_커스텀_리프레시_컨트롤_시작() {
        // Given: 리프레시가 아직 시작되지 않았을 때
        expect(self.customRefreshControl.refreshIndicator.isAnimating).to(beFalse(), description: "리프레시가 시작되지 않아야 한다.")
        
        // When: 리프레시를 시작했을 때
        customRefreshControl.beginRefreshing()
        
        // Then: 리프레시가 시작되어야 한다.
        expect(self.customRefreshControl.refreshIndicator.isAnimating).to(beTrue(), description: "리프레시가 시작되어야 한다.")
    }

    func test_resetRefreshControl_애니메이션_초기화() {
        // Given: CustomRefreshControl의 인스턴스 생성 후, 애니메이션 시작 상태 설정
        let customRefreshControl = CustomRefreshControl()
        customRefreshControl.beginRefreshing()

        // 리프레시 애니메이션 시작 상태 확인
        expect(customRefreshControl.refreshIndicator.isAnimating).to(beTrue(), description: "애니메이션이 시작되어야 합니다.")
        expect(customRefreshControl.refreshImageView.alpha).to(equal(0), description: "애니메이션이 시작되면, 리프레시 이미지의 알파 값은 0이어야 한다.")

        // When: resetRefreshControl() 함수 호출
        customRefreshControl.resetRefreshControl()

        // Then: 애니메이션 및 기타 상태가 초기화되었는지 확인
        expect(customRefreshControl.refreshIndicator.isAnimating).to(beFalse(), description: "애니메이션이 중지되어야 한다.")
        expect(customRefreshControl.refreshImageView.alpha).to(equal(1.0), description: "애니메이션이 중지되면, 리프레시 이미지의 알파 값은 1이어야 한다.")
    }
}
