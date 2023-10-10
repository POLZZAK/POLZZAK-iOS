//
//  PullToRefreshDemoAppUITests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble

final class PullToRefreshDemoAppUITests: XCTestCase {

    enum Constants {
        static let topPadding = 50.0
        static let cellID = "cell"
        static let timeout = NimbleTimeInterval.seconds(5)
    }
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_드래그하여_리프레시_했을_때_첫_셀의_색상이_변하는지() {
        // Given: 초기 앱의 상태 설정
        let initialCell = app.tables.cells.element(matching: .cell, identifier: Constants.cellID + "0")
        let initialColor = initialCell.label
        
        // When: 사용자 액션을 시뮬레이션
        let start = app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.25))
        let end = start.withOffset(CGVector(dx: 0, dy: 300 + Constants.topPadding))
        start.press(forDuration: 0.1, thenDragTo: end)
        
        // 동적 대기: 셀의 색상이 변경될 때까지 대기
        waitUntil(timeout: Constants.timeout) { [weak self] done in
            let refreshedColor = self?.app.tables.cells.element(matching: .cell, identifier: Constants.cellID + "0").label
            if initialColor != refreshedColor {
                done()
            }
        }
        
        let refreshedCell = app.tables.cells.element(matching: .cell, identifier: Constants.cellID + "0")
        let refreshedColor = refreshedCell.label
        
        // Then: 결과 검증
        expect(initialColor).toNot(equal(refreshedColor), description: "리프레시 후 초기 색상 '\(initialColor)'과 새로운 색상 '\(refreshedColor)'이 다르게 보여져야 한다.")
    }
}
