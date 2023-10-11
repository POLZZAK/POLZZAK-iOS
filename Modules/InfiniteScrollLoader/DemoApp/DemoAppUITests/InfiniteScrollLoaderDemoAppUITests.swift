//
//  InfiniteScrollLoaderDemoAppUITests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble

final class InfiniteScrollLoaderDemoAppUITests: XCTestCase {
    
    enum Constants {
        static let cellID = "cell"
        static let initialCellCount = 10
        static let addedCellCount = 10
        static let timeout = NimbleTimeInterval.seconds(5)
    }
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_최하단으로_스크롤_후_위로_드래그_했을_때_새로운_데이터가_로드되는지() {
        // Given: 초기 앱의 상태 설정
        app.tables.element(boundBy: 0).swipeUp()
        
        // When: 최하단에서 다시 위로 드래그
        let start = app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9))
        let end = start.withOffset(CGVector(dx: 0, dy: -1000))
        start.press(forDuration: 0.1, thenDragTo: end)

        // 동적 대기: 새로운 데이터가 로드될 때까지 대기
        waitUntil(timeout: Constants.timeout) { done in
            let newLastCell = self.app.tables.cells.element(matching: .cell, identifier: Constants.cellID + "\(Constants.initialCellCount + Constants.addedCellCount - 1)")
            if newLastCell.exists {
                done()
            }
        }
        
        let newLastCell = app.tables.cells.element(matching: .cell, identifier: Constants.cellID + "\(Constants.initialCellCount + Constants.addedCellCount - 1)")
        
        // Then: 결과 검증
        expect(newLastCell.exists).to(beTrue(), description: "최하단에서 위로 드래그 했을 때 새로운 마지막 셀이 보여져야 한다.")
    }
}
