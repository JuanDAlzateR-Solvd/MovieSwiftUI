//
//  Untitled.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 23/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

extension XCUIElement {

    @discardableResult
    func waitUntilExists(
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        let exists = waitForExistence(timeout: timeout)

        XCTAssertTrue(
            exists,
            "Expected element to exist within \(timeout) seconds, but it did not appear.",
            file: file,
            line: line
        )

        return self
    }

    @discardableResult
    func waitUntilHittable(
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        let predicate = NSPredicate(format: "exists == true AND hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(
            result,
            .completed,
            "Expected element to become hittable within \(timeout) seconds, but it did not.",
            file: file,
            line: line
        )

        return self
    }

    @discardableResult
    func waitUntilNotExists(
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(
            result,
            .completed,
            "Expected element to disappear within \(timeout) seconds, but it is still present.",
            file: file,
            line: line
        )

        return self
    }
}
