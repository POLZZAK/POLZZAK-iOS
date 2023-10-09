//
//  SwipeToDeleteDemoAppUITests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble

class SwipeToDeleteDemoAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up actions
    }

    func test_팬제스처로_셀을_삭제했을때_정확한_인덱스가_삭제되는지() {
        // Given: 초기 앱의 상태 설정
        let initialCell = app.tables.cells.element(matching: .cell, identifier: "1")
        // When: 팬 제스처를 사용하여 해당 셀을 삭제 시뮬레이션
        let start = initialCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = start.withOffset(CGVector(dx: -300, dy: 0))
        start.press(forDuration: 0.1, thenDragTo: end)
        app.buttons["1"].tap()

        // Then: 결과 검증
        expect(initialCell.exists).to(beFalse(), description: "1번째 셀이 삭제되어 존재하지 않아야 합니다.")
    }
}
