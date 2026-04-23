//
//  XCUIElement+Interactions.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 23/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

extension XCUIElement {

    func tapWhenHittable(
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        waitUntilHittable(timeout: timeout, file: file, line: line)
        tap()
    }

    func typeTextWhenHittable(
        _ text: String,
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        waitUntilHittable(timeout: timeout, file: file, line: line)
        tap()
        typeText(text)
    }
}
