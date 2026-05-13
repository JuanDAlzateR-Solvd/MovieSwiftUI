//
//  BaseUITestCase.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 6/05/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

class BaseUITestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()

        TestTrace.step("Launch app") {
            app.launch()
        }
    }

    override func tearDownWithError() throws {
        if let app = app,
           let testRun = testRun,
           testRun.failureCount > 0 {
            TestTrace.attachScreenshot(
                name: "Failure screenshot - \(name)",
                app: app
            )
        }

        app = nil
    }
}
