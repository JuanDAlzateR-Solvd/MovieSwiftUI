//
//  TestTrace.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 6/05/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

enum TestTrace {

    @discardableResult
    static func step<T>(
        _ name: String,
        _ block: () throws -> T
    ) rethrows -> T {
        try XCTContext.runActivity(named: name) { _ in
            try block()
        }
    }

    static func attachScreenshot(
        name: String,
        app: XCUIApplication,
        lifetime: XCTAttachment.Lifetime = .keepAlways
    ) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = lifetime

        XCTContext.runActivity(named: "Screenshot: \(name)") { activity in
            activity.add(attachment)
        }
    }
}
