//
//  DynamicTabViewDemoAppUITests.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import XCTest
import Nimble

final class DynamicTabViewDemoAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testExample() {
        // UI tests code
    }
}