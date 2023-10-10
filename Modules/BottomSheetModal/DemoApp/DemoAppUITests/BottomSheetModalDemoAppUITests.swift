//
//  BottomSheetModalDemoAppUITests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble

import BottomSheetModal
//import Extension

final class BottomSheetModalDemoAppUITests: XCTestCase {
    
    enum Constants {
        static let shortStateYOffset: CGFloat = UIScreen.main.bounds.height
        static let fullStateYOffset: CGFloat = UIScreen.main.bounds.height * 0.1
        static let timeout = NimbleTimeInterval.seconds(5)
    }
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_버튼을_누르면_모달이_올라오는지() {
        // Given: 초기 앱의 상태 설정
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.viewDidLoad()
        
        // When: 사용자 액션을 시뮬레이션
        let showButton = app.buttons["Show Bottom Sheet"]
        showButton.tap()
        
        // Then: 결과 검증
        let screenHeight = app.windows.firstMatch.frame.height
        let handleViewY = app.otherElements["Handle"].frame.origin.y
        let expectedPositionPercentage = 0.75
        let expectedYPosition = screenHeight * expectedPositionPercentage
        
        // 오차 범위 설정
        let tolerance = screenHeight * 0.05

        expect(handleViewY).to(beCloseTo(expectedYPosition, within: tolerance), description: "핸들러의 Y 위치가 .short 상태에 맞게 표시되어야 합니다.")
    }
    
    func test_모달을_위로_드래그하면_full_상태가_되는지() {
        // Given: 초기 앱의 상태 설정
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.viewDidLoad()
        
        let showButton = app.buttons["Show Bottom Sheet"]
        showButton.tap()

        let screenHeight = app.windows.firstMatch.frame.height
        let demoLabel = app.staticTexts["This is a bottom sheet."]
        let statusBarHeight = CGFloat(Double(demoLabel.identifier) ?? 0.0)
        
        // When: 사용자 액션을 시뮬레이션 (모달을 위로 드래그)
        let start = app.otherElements["Handle"].coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let end = start.withOffset(CGVector(dx: 0, dy: -(screenHeight) * 0.6))
        start.press(forDuration: 0.1, thenDragTo: end)
        
        // Then: 결과 검증
        let handleViewY = app.otherElements["Handle"].frame.origin.y
        expect(handleViewY).to(equal(statusBarHeight), description: "모달을 위로 드래그한 후 핸들러의 Y 위치가 .full 상태에 맞게 표시되어야 합니다.")
    }

    func test_모달을_아래로_드래그하면_모달이_닫히는지() {
        // Given: 초기 앱의 상태 설정
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.viewDidLoad()
        
        let showButton = app.buttons["Show Bottom Sheet"]
        showButton.tap()

        // When: 사용자 액션을 시뮬레이션 (모달을 아래로 드래그)
        let handleElement = app.otherElements["Handle"]
        let start = handleElement.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let end = start.withOffset(CGVector(dx: 0, dy: 300))
        start.press(forDuration: 0.1, thenDragTo: end)
        
        // Then: 결과 검증
        let demoLabel = app.staticTexts["This is a bottom sheet."]
        expect(demoLabel.exists).to(beFalse(), description: "모달을 아래로 드래그한 후에는 'This is a bottom sheet.' 라벨이 보이지 않아야 합니다.")
    }
}
