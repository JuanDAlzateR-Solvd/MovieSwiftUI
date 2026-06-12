//
//  MovieDetailsScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

final class MovieDetailsScreen: BaseScreen {

    private var addButton: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifiers.MovieDetail.addButton]
    }

    private var overview: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifiers.MovieDetail.overview]
    }

    override var loadableElement: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifiers.MovieDetail.screen]
    }

    @discardableResult
    func assertMovieDetailsAreDisplayed(timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Movie Details: assert details screen is displayed") {
            waitUntilLoaded(timeout: timeout)
            addButton.waitUntilExists(timeout: timeout)
        }
        return self
    }
}
